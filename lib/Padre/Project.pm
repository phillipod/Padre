package Padre::Project;

# Base project functionality for Padre

use 5.008;
use strict;
use warnings;
use File::Spec ();

our $VERSION = '0.81';





######################################################################
# Class Methods

sub class {
	my $class = shift;
	my $root  = shift;
	unless ( -d $root ) {

		# Carp::croak("Project directory '$root' does not exist");
		# Project root doesn't exist, this might cause problems
		# but croaking completly crashs Padre. Fix for #819
		require Padre::Current;
		Padre::Current->main->error(
			sprintf(
				Wx::gettext(
					      'Project directory %s does not exist (any longer). '
						. 'This is fatal and will cause problems, please close or '
						. 'save-as this file unless you know what you are doing.'
				),
				$root
			)
		);
		return 'Padre::Project::Null';
	}

	# There are several main indicators this is a Perl project
	if ( -f File::Spec->catfile( $root, 'Makefile.PL' ) ) {
		return 'Padre::Project::Perl';
	}
	if ( -f File::Spec->catfile( $root, 'Build.PL' ) ) {
		return 'Padre::Project::Perl';
	}
	if ( -f File::Spec->catfile( $root, 'dist.ini' ) ) {
		return 'Padre::Project::Perl';
	}

	# Is this a manually configured explicit Padre project
	if ( -f File::Spec->catfile( $root, 'padre.yml' ) ) {
		return 'Padre::Project';
	}

	# If there are no language-specific indicators, check to see if
	# this directory is (ideally the root of) a version control checkout.
	foreach my $vcs ( '.svn', '.git', '.hg', '.bzr' ) {
		if ( -d File::Spec->catfile($root, $vcs) ) {
			return 'Padre::Project';
		}
	}
	if ( -f File::Spec->catfile($root, 'CSV', 'Repository') ) {
		return 'Padre::Project';
	}

	# This is otherwise not recognisable as a "project"
	return 'Padre::Project::Null';
}





######################################################################
# Constructor and Accessors

sub new {
	my $class = shift;
	my $self = bless {@_}, $class;

	# Check the root directory
	unless ( defined $self->root ) {
		Carp::croak("Did not provide a root directory");
	}
	unless ( -d $self->root ) {
		return undef;

		# Carp::croak( "Root directory " . $self->root . " does not exist" );
	}

	# Check for a padre.yml file
	my $padre_yml = File::Spec->catfile(
		$self->root,
		'padre.yml',
	);
	if ( -f $padre_yml ) {
		$self->{padre_yml} = $padre_yml;
	}

	return $self;
}

sub from_file {
	my $class = shift;
	my $file  = shift;

	# Split and scan
	my ( $v, $d, $f ) = File::Spec->splitpath($file);
	my @d = File::Spec->splitdir($d);
	if ( defined $d[-1] and $d[-1] eq '' ) {
		pop @d;
	}
	foreach my $n ( reverse 0 .. $#d ) {
		my $dir = File::Spec->catdir( @d[ 0 .. $n ] );

		# Check for Dist::Zilla support
		my $dist_ini = File::Spec->catpath( $v, $dir, 'dist.ini' );
		if ( -f $dist_ini ) {
			require Padre::Project::Perl::DZ;
			return Padre::Project::Perl::DZ->new(
				root     => File::Spec->catpath( $v, $dir, '' ),
				dist_ini => $dist_ini,
			);
		}

		# Check for Module::Build support
		my $build_pl = File::Spec->catpath( $v, $dir, 'Build.PL' );
		if ( -f $build_pl ) {
			require Padre::Project::Perl::MB;
			return Padre::Project::Perl::MB->new(
				root     => File::Spec->catpath( $v, $dir, '' ),
				build_pl => $build_pl,
			);
		}

		# Check for ExtUtils::MakeMaker and Module::Install support
		my $makefile_pl = File::Spec->catpath( $v, $dir, 'Makefile.PL' );
		if ( -f $makefile_pl ) {

			# Differentiate between Module::Install and ExtUtils::MakeMaker
			if (0) {
				require Padre::Project::Perl::MI;
				return Padre::Project::Perl::MI->new(
					root        => File::Spec->catpath( $v, $dir, '' ),
					makefile_pl => $makefile_pl,
				);
			} else {
				require Padre::Project::Perl::EUMM;
				return Padre::Project::Perl::EUMM->new(
					root        => File::Spec->catpath( $v, $dir, '' ),
					makefile_pl => $makefile_pl,
				);
			}
		}

		# Check for an explicit vanilla project
		my $padre_yml = File::Spec->catpath( $v, $dir, 'padre.yml' );
		if ( -f $padre_yml ) {
			return Padre::Project->new(
				root      => File::Spec->catpath( $v, $dir, '' ),
				padre_yml => $padre_yml,
			);
		}

		# Intuit a vanilla project based on a git, mercurial or Bazaar
		# checkout (that use a single directory to indicate the root).
		foreach my $vcs ( '.git', '.hg', '.bzr' ) {
			my $vcs_dir = File::Spec->catpath( $v, $dir, $vcs );
			if ( -d $vcs_dir ) {
				return Padre::Project->new(
					root => File::Spec->catpath( $v, $dir, '' ),
				);
			}
		}

		# Intuit a vanilla project based on a Subversion checkout
		my $svn_dir = File::Spec->catpath( $v, $dir, '.svn' );
		if ( -d $svn_dir ) {
			# This must be the top-most .svn directory
			if ( $n ) {
				# We aren't at the top-most directory in the volume
				my $updir = File::Spec->catdir( @d[ 0 .. $n-1 ] );
				my $svn_updir = File::Spec->catpath( $v, $updir, '.svn' );
				unless ( -d $svn_dir ) {
					return Padre::Project->new(
						root => File::Spec->catpath( $v, $dir, '' ),
					);
				}
			}			
		}

		# Intuit a vanilla project based on a CVS checkout
		my $cvs_dir = File::Spec->catpath(
			$v,
			File::Spec->catdir($dir, 'CVS'),
			'Repository',
		);
		if ( -f $cvs_dir ) {
			# This must be the top-most CVS directory
			if ( $n ) {
				# We aren't at the top-most directory in the volume
				my $updir     = File::Spec->catdir( @d[ 0 .. $n-1 ] );
				my $cvs_updir = File::Spec->catpath(
					$v,
					File::Spec->catdir($updir, 'CVS'),
					'Repository',
				);
				unless ( -f $cvs_dir ) {
					return Padre::Project->new(
						root => File::Spec->catpath( $v, $dir, '' ),
					);
				}
			}			
		}

	}

	# This document is part of the null project
	require Padre::Project::Null;
	return Padre::Project::Null->new(
		root => File::Spec->catpath(
			$v,
			File::Spec->catdir(@d),
			'',
		),
	);
}

sub root {
	$_[0]->{root};
}

sub padre_yml {
	$_[0]->{padre_yml};
}





######################################################################
# Navigation Convenience Methods

sub documents {
	my $self = shift;
	my $root = $self->root;
	require Padre::Current;
	return grep { $_->project_dir eq $root } Padre::Current->main->documents;
}





######################################################################
# Configuration and Intuition

sub config {
	my $self = shift;
	unless ( $self->{config} ) {

		# Get the default config object
		require Padre::Current;
		my $config = Padre::Current->config;

		# If we have a padre.yml file create a custom config object
		if ( $self->{padre_yml} ) {
			require Padre::Config;
			require Padre::Config::Project;
			$self->{config} = Padre::Config->new(
				$config->host,
				$config->human,
				Padre::Config::Project->read(
					$self->{padre_yml},
				),
			);
		} else {
			require Padre::Config;
			$self->{config} = Padre::Config->new(
				$config->host,
				$config->human,
			);
		}
	}
	return $self->{config};
}

# Locate the "primary" file, if the project has one
sub headline {
	return undef;
}

# Intuit the distribution version if possible
sub version {
	return undef;
}





######################################################################
# Process Execution Resources

sub temp {
	$_[0]->{temp} or $_[0]->{temp} = $_[0]->_temp;
}

sub _temp {
	require Padre::Project::Temp;
	Padre::Project::Temp->new;
}

# Synchronise all content from unsaved files in a project to the
# project-specific temporary directory.
sub temp_sync {
	my $self = shift;

	# What files do we need to save
	my @changed = grep { !$_->is_new and $_->is_modified } $self->documents or return 0;

	# Save the files to the temporary directory
	my $temp  = $self->temp;
	my $root  = $temp->root;
	my $files = 0;
	foreach my $document (@changed) {
		my $relative = $document->filename_relative;
		my $tempfile = File::Spec->rel2abs( $relative, $root );
		require File::Path;
		require File::Basename;
		File::Path::mkpath( File::Basename::basedir($tempfile) );
		my $file = Padre::File->new($tempfile);
		$document->write($file) and $files++;
	}

	return $files;
}





######################################################################
# Directory Tree Integration

# A file/directory pattern to support the directory browser.
# The function takes three parameters of the full file path,
# the directory path, and the file name.
# Returns true if the file is visible.
# Returns false if the file is ignored.
# This method is used to support the functionality of the directory browser.
sub ignore_rule {
	return sub {
		if ( $_->{name} =~ /^\./ ) {
			return 0;
		} else {
			return 1;
		}
	};
}

# Alternate form
sub ignore_skip {
	return [
		'(?:^|\\/)\\.',
	];
}

sub name {
	my $self = shift;
	my $name = ( reverse( File::Spec->splitdir( $self->root ) ) )[0];

	if ( !defined $name or $name eq '' ) { # Fallback
		$name = $self->root;
		$name =~ s/^.*[\/\\]//;
	}

	return $name;
}





######################################################################
# Padre::Cache Integration

# The detection of VERSION allows us to make this call without having
# to load modules at project destruction time if it isn't needed.
sub DESTROY {
	if ( defined $_[0]->{root} and $Padre::Cache::VERSION ) {
		Padre::Cache->release( $_[0]->{root} );
	}
}

1;

# Copyright 2008-2011 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
