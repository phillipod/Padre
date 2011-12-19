package Padre::Wx::Dialog::Find;

use 5.008;
use strict;
use warnings;
use Padre::Search        ();
use Padre::Wx::FBP::Find ();

our $VERSION = '0.93';
our @ISA     = qw{
	Padre::Wx::FBP::Find
};





######################################################################
# Constructor

sub new {
	my $class = shift;
	my $self  = $class->SUPER::new(@_);

	# Prepare to be shown.
	$self->CenterOnParent;

	Wx::Event::EVT_KEY_UP(
		$self,
		sub {
			shift->key_up(@_);
		},
	);

	return $self;
}





######################################################################
# Event Handlers

sub find_next_clicked {
	my $self   = shift;
	my $main   = $self->main;
	my $search = $self->as_search;
	if ( $search ) {
		$self->find_term->SaveValue;
	} else {
		# Move the focus back to the search text
		# so they can tweak their search.
		$self->find_term->SetFocus;
		return;
	}

	# Apply the search to the current editor
	my $result = $main->search_next($search);

	# If we're only searching once, we won't need the dialog any more
	if ( $self->find_first->GetValue ) {
		$self->Hide;

	} elsif ( not $result ) {
		$main->info(
			sprintf(
				Wx::gettext('No matches found for "%s".'),
				$self->find_term->GetValue,
			),
			Wx::gettext('Search')
		);

		# Move the focus back to the search text
		# so they can tweak their search.
		$self->find_term->SetFocus;
	}

	return;
}

sub key_up {
	my $self  = shift;
	my $event = shift;
	my $mod   = $event->GetModifiers || 0;
	my $code  = $event->GetKeyCode;

	# A fixed key binding isn't good at all.
	# TODO: Change this to the action's keybinding

	# Handle Ctrl-F only
	return unless ( $mod == 2 ) and ( $code == 70 );

	if ( $self->{wait_ctrl_f} ) {

		# Ctrl-F in the editor window triggers a menu action which is fired before the key is up again
		# This skips the key_up event for the menu ctrl-f
		$self->{wait_ctrl_f} = 0;
		return;
	}

	$self->{cycle_ctrl_f} = 1;

	$self->Hide;

	return;
}





######################################################################
# Main Methods

sub run {
	my $self = shift;
	my $main = $self->main;

	# Clear
	$self->{cycle_ctrl_f} = 0;

	# Do they have a specific search term in mind?
	my $text = $self->current->text;
	$text = '' if $text =~ /\n/;

	# Clear out and reset the search term box
	$self->find_term->refresh($text);
	$self->find_term->SetFocus;

	# Refresh
	$self->refresh;

	# Hide the Fast Find if visible
	$main->show_findfast(0);

	# Show the dialog
	$self->ShowModal;

	# Return to the current editor
	$main->editor_focus;

	return;
}

# Ensure the find button is only enabled if the field values are valid
sub refresh {
	my $self   = shift;
	my $enable = $self->find_term->GetValue ne '';
	$self->find_next->Enable($enable);
	$self->find_all->Enable($enable);
}

# Generate a search object for the current dialog state
sub as_search {
	my $self = shift;
	Padre::Search->new(
		find_term    => $self->find_term->GetValue,
		find_case    => $self->find_case->GetValue,
		find_regex   => $self->find_regex->GetValue,
		find_reverse => $self->find_reverse->GetValue
	);
}

1;

# Copyright 2008-2011 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
