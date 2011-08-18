package Padre::Wx::FBP::Preferences;

## no critic

# This module was generated by Padre::Plugin::FormBuilder::Perl.
# To change this module edit the original .fbp file and regenerate.
# DO NOT MODIFY THIS FILE BY HAND!

use 5.008;
use strict;
use warnings;
use Padre::Wx ();
use Padre::Wx::Role::Main ();
use Padre::Wx::Editor ();

our $VERSION = '0.91';
our @ISA     = qw{
	Padre::Wx::Role::Main
	Wx::Dialog
};

sub new {
	my $class  = shift;
	my $parent = shift;

	my $self = $class->SUPER::new(
		$parent,
		-1,
		Wx::gettext("Padre Preferences"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::DEFAULT_DIALOG_STYLE | Wx::RESIZE_BORDER,
	);

	$self->{treebook} = Wx::Treebook->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_panel3 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	$self->{m_staticText341} = Wx::StaticText->new(
		$m_panel3,
		-1,
		Wx::gettext("Editor Style"),
	);
	$self->{m_staticText341}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{editor_style} = Wx::Choice->new(
		$m_panel3,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{editor_style}->SetSelection(0);

	Wx::Event::EVT_CHOICE(
		$self,
		$self->{editor_style},
		sub {
			shift->preview_refresh(@_);
		},
	);

	$self->{m_staticline21} = Wx::StaticLine->new(
		$m_panel3,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{main_output_ansi} = Wx::CheckBox->new(
		$m_panel3,
		-1,
		Wx::gettext("Coloured text in output window (ANSI)"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{info_on_statusbar} = Wx::CheckBox->new(
		$m_panel3,
		-1,
		Wx::gettext("Show low priority info messages on status bar (not in a popup)"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{editor_right_margin_enable} = Wx::CheckBox->new(
		$m_panel3,
		-1,
		Wx::gettext("Show right margin at column"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_CHECKBOX(
		$self,
		$self->{editor_right_margin_enable},
		sub {
			shift->preview_refresh(@_);
		},
	);

	$self->{editor_right_margin_column} = Wx::TextCtrl->new(
		$m_panel3,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_TEXT(
		$self,
		$self->{editor_right_margin_column},
		sub {
			shift->preview_refresh(@_);
		},
	);

	my $m_staticText17 = Wx::StaticText->new(
		$m_panel3,
		-1,
		Wx::gettext("Editor Font"),
	);

	$self->{editor_font} = Wx::FontPickerCtrl->new(
		$m_panel3,
		-1,
		Wx::NullFont,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::FNTP_DEFAULT_STYLE,
	);
	$self->{editor_font}->SetMaxPointSize(100);

	Wx::Event::EVT_FONTPICKER_CHANGED(
		$self,
		$self->{editor_font},
		sub {
			shift->preview_refresh(@_);
		},
	);

	my $m_staticText18 = Wx::StaticText->new(
		$m_panel3,
		-1,
		Wx::gettext("Editor Current Line Background Colour"),
	);

	$self->{editor_currentline_color} = Wx::ColourPickerCtrl->new(
		$m_panel3,
		-1,
		Wx::Colour->new( 0, 0, 0 ),
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::CLRP_DEFAULT_STYLE,
	);

	Wx::Event::EVT_COLOURPICKER_CHANGED(
		$self,
		$self->{editor_currentline_color},
		sub {
			shift->preview_refresh(@_);
		},
	);

	$self->{m_staticline2} = Wx::StaticLine->new(
		$m_panel3,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{m_staticText331} = Wx::StaticText->new(
		$m_panel3,
		-1,
		Wx::gettext("Appearance Preview"),
	);
	$self->{m_staticText331}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{preview} = Padre::Wx::Editor->new(
		$m_panel3,
		-1,
	);

	my $m_panel4 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	$self->{m_staticText36111} = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("Content Assist"),
	);
	$self->{m_staticText36111}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{m_staticline411} = Wx::StaticLine->new(
		$m_panel4,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{autocomplete_always} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Autocomplete always while typing"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{autocomplete_method} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Autocomplete new methods in packages"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{autocomplete_subroutine} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Autocomplete new functions in scripts"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText271 = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("Minimum length of suggestions"),
	);

	$self->{lang_perl5_autocomplete_min_suggestion_len} = Wx::SpinCtrl->new(
		$m_panel4,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		1,
		64,
		1,
	);

	my $m_staticText281 = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("Maximum number of suggestions"),
	);

	$self->{lang_perl5_autocomplete_max_suggestions} = Wx::SpinCtrl->new(
		$m_panel4,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		5,
		256,
		5,
	);

	my $m_staticText291 = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("Minimum characters for autocomplete"),
	);

	$self->{lang_perl5_autocomplete_min_chars} = Wx::SpinCtrl->new(
		$m_panel4,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		1,
		16,
		1,
	);

	$self->{m_staticText3511} = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("Braces Assist"),
	);
	$self->{m_staticText3511}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{m_staticline4111} = Wx::StaticLine->new(
		$m_panel4,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{autocomplete_brackets} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Autocomplete brackets"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{autocomplete_multiclosebracket} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Add another closing bracket if there already is one"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{m_staticText35111} = Wx::StaticText->new(
		$m_panel4,
		-1,
		Wx::gettext("POD"),
	);
	$self->{m_staticText35111}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{m_staticline41111} = Wx::StaticLine->new(
		$m_panel4,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{editor_fold_pod} = Wx::CheckBox->new(
		$m_panel4,
		-1,
		Wx::gettext("Auto-fold POD markup when code folding enabled"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_panel2 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	$self->{swap_ctrl_tab_alt_right} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Use panel order for Ctrl-Tab (not usage history)"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{save_autoclean} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Clean up file content on saving (for supported document types)"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText41 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Open files"),
	);

	$self->{startup_files} = Wx::Choice->new(
		$m_panel2,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{startup_files}->SetSelection(0);

	my $m_staticText5 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Default projects directory"),
	);

	$self->{default_projects_directory} = Wx::DirPickerCtrl->new(
		$m_panel2,
		-1,
		"",
		Wx::gettext("Select a folder"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::DIRP_DEFAULT_STYLE,
	);

	$self->{main_singleinstance} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Open files in existing Padre"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText6 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Methods order"),
	);

	$self->{main_functions_order} = Wx::Choice->new(
		$m_panel2,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{main_functions_order}->SetSelection(0);

	my $m_staticText7 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Prefered language for error diagnostics"),
	);

	$self->{locale_perldiag} = Wx::Choice->new(
		$m_panel2,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{locale_perldiag}->SetSelection(0);

	my $m_staticText9 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Check for file updates on disk every (seconds)"),
	);

	$self->{update_file_from_disk_interval} = Wx::SpinCtrl->new(
		$m_panel2,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		0,
		10,
		0,
	);

	my $m_staticText10 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("Cursor blink rate (milliseconds - 0 = off, 500 = default)"),
	);

	$self->{editor_cursor_blink} = Wx::TextCtrl->new(
		$m_panel2,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{editor_smart_highlight_enable} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Enable Smart highlighting while typing"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{window_list_shorten_path} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Shorten the common path in window list"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{mid_button_paste} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Use X11 middle button paste style"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText11 = Wx::StaticText->new(
		$m_panel2,
		-1,
		Wx::gettext("RegExp for TODO panel"),
	);

	$self->{todo_regexp} = Wx::TextCtrl->new(
		$m_panel2,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{startup_splash} = Wx::CheckBox->new(
		$m_panel2,
		-1,
		Wx::gettext("Use splash screen"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_panel6 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	my $m_staticText25 = Wx::StaticText->new(
		$m_panel6,
		-1,
		Wx::gettext("Diff tool"),
	);

	$self->{bin_diff} = Wx::FilePickerCtrl->new(
		$m_panel6,
		-1,
		"",
		Wx::gettext("Select a file"),
		"*.*",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::FLP_DEFAULT_STYLE,
	);

	my $m_panel1 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	$self->{editor_indent_guess} = Wx::Button->new(
		$m_panel1,
		-1,
		Wx::gettext("Guess from Current Document"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{editor_indent_guess},
		sub {
			shift->guess(@_);
		},
	);

	$self->{editor_indent_auto} = Wx::CheckBox->new(
		$m_panel1,
		-1,
		Wx::gettext("Automatic indentation style detection"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{editor_indent_tab} = Wx::CheckBox->new(
		$m_panel1,
		-1,
		Wx::gettext("Use Tabs"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText2 = Wx::StaticText->new(
		$m_panel1,
		-1,
		Wx::gettext("Tab display size (in spaces)"),
	);

	$self->{editor_indent_tab_width} = Wx::SpinCtrl->new(
		$m_panel1,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		1,
		16,
		8,
	);

	my $m_staticText3 = Wx::StaticText->new(
		$m_panel1,
		-1,
		Wx::gettext("Indentation width (in columns)"),
	);

	$self->{editor_indent_width} = Wx::SpinCtrl->new(
		$m_panel1,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		1,
		10,
		8,
	);

	my $m_staticText4 = Wx::StaticText->new(
		$m_panel1,
		-1,
		Wx::gettext("Autoindent"),
	);

	$self->{editor_autoindent} = Wx::Choice->new(
		$m_panel1,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{editor_autoindent}->SetSelection(0);

	my $m_panel7 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	$self->{m_staticText39} = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Language Integration"),
	);
	$self->{m_staticText39}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{m_staticline10} = Wx::StaticLine->new(
		$m_panel7,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	my $m_staticText34 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Perl interpreter"),
	);

	$self->{run_perl_cmd} = Wx::TextCtrl->new(
		$m_panel7,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{run_use_external_window} = Wx::CheckBox->new(
		$m_panel7,
		-1,
		Wx::gettext("Use external window for execution"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText35 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Interpreter arguments"),
	);

	$self->{run_interpreter_args_default} = Wx::TextCtrl->new(
		$m_panel7,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText36 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Include directory:  -I<dir>\nEnable tainting checks:  -T\nEnable many useful warnings:  -w\nEnable all warnings:  -W\nDisable all warnings:  -X"),
	);

	my $m_staticText37 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Script arguments"),
	);

	$self->{run_script_args_default} = Wx::TextCtrl->new(
		$m_panel7,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{m_staticText351} = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Editor Options"),
	);
	$self->{m_staticText351}->SetFont(
		Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" )
	);

	$self->{m_staticline11} = Wx::StaticLine->new(
		$m_panel7,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{lang_perl5_beginner} = Wx::CheckBox->new(
		$m_panel7,
		-1,
		Wx::gettext("Perl beginner mode"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{editor_wordwrap} = Wx::CheckBox->new(
		$m_panel7,
		-1,
		Wx::gettext("Default word wrap on for each file"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticText8 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Default line ending"),
	);

	$self->{default_line_ending} = Wx::Choice->new(
		$m_panel7,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{default_line_ending}->SetSelection(0);

	$self->{m_staticText371} = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Syntax Highlighter"),
	);

	$self->{lang_perl5_lexer} = Wx::Choice->new(
		$m_panel7,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		[],
	);
	$self->{lang_perl5_lexer}->SetSelection(0);

	my $m_staticText26 = Wx::StaticText->new(
		$m_panel7,
		-1,
		Wx::gettext("Perl ctags file"),
	);

	$self->{lang_perl5_tags_file} = Wx::FilePickerCtrl->new(
		$m_panel7,
		-1,
		"",
		Wx::gettext("Select a file"),
		"*.*",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::FLP_DEFAULT_STYLE,
	);

	my $m_panel8 = Wx::Panel->new(
		$self->{treebook},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxTAB_TRAVERSAL,
	);

	my $m_staticText30 = Wx::StaticText->new(
		$m_panel8,
		-1,
		Wx::gettext("File access via HTTP"),
	);

	my $m_staticText31 = Wx::StaticText->new(
		$m_panel8,
		-1,
		Wx::gettext("Timeout (in seconds)"),
	);

	$self->{file_http_timeout} = Wx::SpinCtrl->new(
		$m_panel8,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		10,
		900,
		10,
	);

	my $m_staticText32 = Wx::StaticText->new(
		$m_panel8,
		-1,
		Wx::gettext("File access via FTP"),
	);

	my $m_staticText33 = Wx::StaticText->new(
		$m_panel8,
		-1,
		Wx::gettext("Timeout (in seconds)"),
	);

	$self->{file_ftp_timeout} = Wx::SpinCtrl->new(
		$m_panel8,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxSP_ARROW_KEYS,
		10,
		900,
		10,
	);

	$self->{file_ftp_passive} = Wx::CheckBox->new(
		$m_panel8,
		-1,
		Wx::gettext("Use FTP passive mode"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $m_staticline1 = Wx::StaticLine->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::wxLI_HORIZONTAL,
	);

	$self->{save} = Wx::Button->new(
		$self,
		Wx::ID_OK,
		Wx::gettext("Save"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);
	$self->{save}->SetDefault;

	$self->{advanced} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("Advanced..."),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{advanced},
		sub {
			shift->advanced(@_);
		},
	);

	$self->{cancel} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("Cancel"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{cancel},
		sub {
			shift->cancel(@_);
		},
	);

	my $fgSizer91 = Wx::FlexGridSizer->new( 1, 2, 0, 0 );
	$fgSizer91->SetFlexibleDirection(Wx::BOTH);
	$fgSizer91->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer91->Add( $self->{m_staticText341}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer91->Add( $self->{editor_style}, 0, Wx::ALL, 5 );

	my $fgSizer4 = Wx::FlexGridSizer->new( 6, 2, 0, 10 );
	$fgSizer4->AddGrowableCol(0);
	$fgSizer4->AddGrowableCol(1);
	$fgSizer4->SetFlexibleDirection(Wx::BOTH);
	$fgSizer4->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer4->Add( $self->{main_output_ansi}, 0, Wx::ALL, 5 );
	$fgSizer4->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer4->Add( $self->{info_on_statusbar}, 0, Wx::ALL, 5 );
	$fgSizer4->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer4->Add( $self->{editor_right_margin_enable}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer4->Add( $self->{editor_right_margin_column}, 0, Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer4->Add( $m_staticText17, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer4->Add( $self->{editor_font}, 0, Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer4->Add( $m_staticText18, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer4->Add( $self->{editor_currentline_color}, 0, Wx::ALL | Wx::EXPAND, 5 );

	my $bSizer4 = Wx::BoxSizer->new(Wx::VERTICAL);
	$bSizer4->Add( $fgSizer91, 0, Wx::EXPAND, 5 );
	$bSizer4->Add( $self->{m_staticline21}, 0, Wx::BOTTOM | Wx::EXPAND | Wx::TOP, 5 );
	$bSizer4->Add( $fgSizer4, 0, Wx::EXPAND, 0 );
	$bSizer4->Add( $self->{m_staticline2}, 0, Wx::BOTTOM | Wx::EXPAND | Wx::TOP, 5 );
	$bSizer4->Add( $self->{m_staticText331}, 0, Wx::ALL, 5 );
	$bSizer4->Add( $self->{preview}, 1, Wx::EXPAND | Wx::TOP, 5 );

	$m_panel3->SetSizerAndFit($bSizer4);
	$m_panel3->Layout;

	my $fgSizer411 = Wx::FlexGridSizer->new( 6, 2, 0, 0 );
	$fgSizer411->SetFlexibleDirection(Wx::BOTH);
	$fgSizer411->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer411->Add( $self->{autocomplete_always}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer411->Add( $self->{autocomplete_method}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer411->Add( $self->{autocomplete_subroutine}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer411->Add( $m_staticText271, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer411->Add( $self->{lang_perl5_autocomplete_min_suggestion_len}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( $m_staticText281, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer411->Add( $self->{lang_perl5_autocomplete_max_suggestions}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( $m_staticText291, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer411->Add( $self->{lang_perl5_autocomplete_min_chars}, 0, Wx::ALL, 5 );
	$fgSizer411->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer411->Add( 0, 0, 1, Wx::EXPAND, 5 );

	my $fgSizer412 = Wx::FlexGridSizer->new( 2, 1, 0, 0 );
	$fgSizer412->SetFlexibleDirection(Wx::BOTH);
	$fgSizer412->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer412->Add( $self->{autocomplete_brackets}, 0, Wx::ALL, 5 );
	$fgSizer412->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer412->Add( $self->{autocomplete_multiclosebracket}, 0, Wx::ALL, 5 );

	my $fgSizer413 = Wx::FlexGridSizer->new( 1, 1, 0, 0 );
	$fgSizer413->SetFlexibleDirection(Wx::BOTH);
	$fgSizer413->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer413->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer413->Add( $self->{editor_fold_pod}, 0, Wx::ALL, 5 );
	$fgSizer413->Add( 0, 0, 1, Wx::EXPAND, 5 );

	my $bSizer41 = Wx::BoxSizer->new(Wx::VERTICAL);
	$bSizer41->Add( $self->{m_staticText36111}, 0, Wx::ALL, 5 );
	$bSizer41->Add( $self->{m_staticline411}, 0, Wx::EXPAND | Wx::ALL, 5 );
	$bSizer41->Add( $fgSizer411, 0, Wx::EXPAND, 5 );
	$bSizer41->Add( $self->{m_staticText3511}, 0, Wx::ALL, 5 );
	$bSizer41->Add( $self->{m_staticline4111}, 0, Wx::EXPAND | Wx::ALL, 5 );
	$bSizer41->Add( $fgSizer412, 0, Wx::EXPAND, 5 );
	$bSizer41->Add( $self->{m_staticText35111}, 0, Wx::ALL, 5 );
	$bSizer41->Add( $self->{m_staticline41111}, 0, Wx::EXPAND | Wx::ALL, 5 );
	$bSizer41->Add( $fgSizer413, 0, Wx::EXPAND, 5 );

	$m_panel4->SetSizerAndFit($bSizer41);
	$m_panel4->Layout;

	my $fgSizer3 = Wx::FlexGridSizer->new( 14, 2, 0, 0 );
	$fgSizer3->AddGrowableCol(0);
	$fgSizer3->AddGrowableCol(1);
	$fgSizer3->SetFlexibleDirection(Wx::BOTH);
	$fgSizer3->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_NONE);
	$fgSizer3->Add( $self->{swap_ctrl_tab_alt_right}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{save_autoclean}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText41, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer3->Add( $self->{startup_files}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText5, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer3->Add( $self->{default_projects_directory}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{main_singleinstance}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText6, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer3->Add( $self->{main_functions_order}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText7, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer3->Add( $self->{locale_perldiag}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText9, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer3->Add( $self->{update_file_from_disk_interval}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText10, 0, Wx::ALL, 5 );
	$fgSizer3->Add( $self->{editor_cursor_blink}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{editor_smart_highlight_enable}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{window_list_shorten_path}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{mid_button_paste}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer3->Add( $m_staticText11, 0, Wx::ALL, 5 );
	$fgSizer3->Add( $self->{todo_regexp}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer3->Add( $self->{startup_splash}, 0, Wx::ALL, 5 );
	$fgSizer3->Add( 0, 0, 1, Wx::EXPAND, 5 );

	$m_panel2->SetSizerAndFit($fgSizer3);
	$m_panel2->Layout;

	my $fgSizer6 = Wx::FlexGridSizer->new( 1, 2, 0, 0 );
	$fgSizer6->AddGrowableCol(1);
	$fgSizer6->SetFlexibleDirection(Wx::BOTH);
	$fgSizer6->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer6->Add( $m_staticText25, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer6->Add( $self->{bin_diff}, 0, Wx::ALL | Wx::EXPAND, 5 );

	$m_panel6->SetSizerAndFit($fgSizer6);
	$m_panel6->Layout;

	my $fgSizer2 = Wx::FlexGridSizer->new( 6, 2, 0, 0 );
	$fgSizer2->SetFlexibleDirection(Wx::BOTH);
	$fgSizer2->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_ALL);
	$fgSizer2->Add( $self->{editor_indent_guess}, 0, Wx::ALL, 5 );
	$fgSizer2->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer2->Add( $self->{editor_indent_auto}, 0, Wx::ALL, 5 );
	$fgSizer2->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer2->Add( $self->{editor_indent_tab}, 0, Wx::ALL, 5 );
	$fgSizer2->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer2->Add( $m_staticText2, 0, Wx::ALL, 5 );
	$fgSizer2->Add( $self->{editor_indent_tab_width}, 0, Wx::ALL, 5 );
	$fgSizer2->Add( $m_staticText3, 0, Wx::ALL, 5 );
	$fgSizer2->Add( $self->{editor_indent_width}, 0, Wx::ALL, 5 );
	$fgSizer2->Add( $m_staticText4, 0, Wx::ALL, 5 );
	$fgSizer2->Add( $self->{editor_autoindent}, 0, Wx::ALL, 5 );

	$m_panel1->SetSizerAndFit($fgSizer2);
	$m_panel1->Layout;

	my $fgSizer71 = Wx::FlexGridSizer->new( 5, 2, 0, 0 );
	$fgSizer71->SetFlexibleDirection(Wx::BOTH);
	$fgSizer71->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_ALL);
	$fgSizer71->Add( $m_staticText34, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer71->Add( $self->{run_perl_cmd}, 0, Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer71->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer71->Add( $self->{run_use_external_window}, 0, Wx::ALL, 5 );
	$fgSizer71->Add( $m_staticText35, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer71->Add( $self->{run_interpreter_args_default}, 0, Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer71->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer71->Add( $m_staticText36, 0, Wx::ALL, 5 );
	$fgSizer71->Add( $m_staticText37, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer71->Add( $self->{run_script_args_default}, 0, Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer71->Add( 0, 0, 1, Wx::EXPAND, 5 );

	my $fgSizer72 = Wx::FlexGridSizer->new( 5, 2, 0, 0 );
	$fgSizer72->SetFlexibleDirection(Wx::BOTH);
	$fgSizer72->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_ALL);
	$fgSizer72->Add( $self->{lang_perl5_beginner}, 0, Wx::ALL, 5 );
	$fgSizer72->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer72->Add( $self->{editor_wordwrap}, 0, Wx::ALL, 5 );
	$fgSizer72->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer72->Add( $m_staticText8, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer72->Add( $self->{default_line_ending}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer72->Add( $self->{m_staticText371}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer72->Add( $self->{lang_perl5_lexer}, 0, Wx::ALIGN_RIGHT | Wx::ALL | Wx::EXPAND, 5 );
	$fgSizer72->Add( $m_staticText26, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer72->Add( $self->{lang_perl5_tags_file}, 0, Wx::ALL | Wx::EXPAND, 5 );

	my $bSizer71 = Wx::BoxSizer->new(Wx::VERTICAL);
	$bSizer71->Add( $self->{m_staticText39}, 0, Wx::ALL, 5 );
	$bSizer71->Add( $self->{m_staticline10}, 0, Wx::EXPAND | Wx::ALL, 5 );
	$bSizer71->Add( $fgSizer71, 0, 0, 5 );
	$bSizer71->Add( $self->{m_staticText351}, 0, Wx::ALL, 5 );
	$bSizer71->Add( $self->{m_staticline11}, 0, Wx::EXPAND | Wx::ALL, 5 );
	$bSizer71->Add( $fgSizer72, 0, 0, 5 );

	$m_panel7->SetSizerAndFit($bSizer71);
	$m_panel7->Layout;

	my $fgSizer8 = Wx::FlexGridSizer->new( 5, 2, 0, 0 );
	$fgSizer8->SetFlexibleDirection(Wx::BOTH);
	$fgSizer8->SetNonFlexibleGrowMode(Wx::FLEX_GROWMODE_SPECIFIED);
	$fgSizer8->Add( $m_staticText30, 0, Wx::ALL, 5 );
	$fgSizer8->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer8->Add( $m_staticText31, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer8->Add( $self->{file_http_timeout}, 0, Wx::ALL, 5 );
	$fgSizer8->Add( $m_staticText32, 0, Wx::ALL, 5 );
	$fgSizer8->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$fgSizer8->Add( $m_staticText33, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$fgSizer8->Add( $self->{file_ftp_timeout}, 0, Wx::ALL, 5 );
	$fgSizer8->Add( $self->{file_ftp_passive}, 0, Wx::ALL, 5 );

	$m_panel8->SetSizerAndFit($fgSizer8);
	$m_panel8->Layout;

	$self->{treebook}->AddPage( $m_panel3, Wx::gettext("Appearance"), 0 );
	$self->{treebook}->AddPage( $m_panel4, Wx::gettext("Auto-Complete"), 0 );
	$self->{treebook}->AddPage( $m_panel2, Wx::gettext("Behaviour"), 0 );
	$self->{treebook}->AddPage( $m_panel6, Wx::gettext("External Tools"), 0 );
	$self->{treebook}->AddPage( $m_panel1, Wx::gettext("Indentation"), 0 );
	$self->{treebook}->AddPage( $m_panel7, Wx::gettext("Language - Perl 5"), 1 );
	$self->{treebook}->AddPage( $m_panel8, Wx::gettext("Local/Remote File Access"), 0 );

	my $buttons = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$buttons->Add( $self->{save}, 0, Wx::ALL, 5 );
	$buttons->Add( $self->{advanced}, 0, Wx::ALL, 5 );
	$buttons->Add( $self->{cancel}, 0, Wx::ALL, 5 );

	my $vsizer = Wx::BoxSizer->new(Wx::VERTICAL);
	$vsizer->Add( $self->{treebook}, 1, Wx::ALL | Wx::EXPAND, 5 );
	$vsizer->Add( $m_staticline1, 0, Wx::ALL | Wx::EXPAND, 5 );
	$vsizer->Add( $buttons, 0, Wx::ALIGN_RIGHT, 5 );

	my $hsizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$hsizer->Add( $vsizer, 1, Wx::ALL | Wx::EXPAND, 5 );

	$self->SetSizerAndFit($hsizer);
	$self->Layout;

	return $self;
}

sub treebook {
	$_[0]->{treebook};
}

sub editor_style {
	$_[0]->{editor_style};
}

sub main_output_ansi {
	$_[0]->{main_output_ansi};
}

sub info_on_statusbar {
	$_[0]->{info_on_statusbar};
}

sub editor_right_margin_enable {
	$_[0]->{editor_right_margin_enable};
}

sub editor_right_margin_column {
	$_[0]->{editor_right_margin_column};
}

sub editor_font {
	$_[0]->{editor_font};
}

sub editor_currentline_color {
	$_[0]->{editor_currentline_color};
}

sub preview {
	$_[0]->{preview};
}

sub autocomplete_always {
	$_[0]->{autocomplete_always};
}

sub autocomplete_method {
	$_[0]->{autocomplete_method};
}

sub autocomplete_subroutine {
	$_[0]->{autocomplete_subroutine};
}

sub lang_perl5_autocomplete_min_suggestion_len {
	$_[0]->{lang_perl5_autocomplete_min_suggestion_len};
}

sub lang_perl5_autocomplete_max_suggestions {
	$_[0]->{lang_perl5_autocomplete_max_suggestions};
}

sub lang_perl5_autocomplete_min_chars {
	$_[0]->{lang_perl5_autocomplete_min_chars};
}

sub autocomplete_brackets {
	$_[0]->{autocomplete_brackets};
}

sub autocomplete_multiclosebracket {
	$_[0]->{autocomplete_multiclosebracket};
}

sub editor_fold_pod {
	$_[0]->{editor_fold_pod};
}

sub swap_ctrl_tab_alt_right {
	$_[0]->{swap_ctrl_tab_alt_right};
}

sub save_autoclean {
	$_[0]->{save_autoclean};
}

sub startup_files {
	$_[0]->{startup_files};
}

sub default_projects_directory {
	$_[0]->{default_projects_directory};
}

sub main_singleinstance {
	$_[0]->{main_singleinstance};
}

sub main_functions_order {
	$_[0]->{main_functions_order};
}

sub locale_perldiag {
	$_[0]->{locale_perldiag};
}

sub update_file_from_disk_interval {
	$_[0]->{update_file_from_disk_interval};
}

sub editor_cursor_blink {
	$_[0]->{editor_cursor_blink};
}

sub editor_smart_highlight_enable {
	$_[0]->{editor_smart_highlight_enable};
}

sub window_list_shorten_path {
	$_[0]->{window_list_shorten_path};
}

sub mid_button_paste {
	$_[0]->{mid_button_paste};
}

sub todo_regexp {
	$_[0]->{todo_regexp};
}

sub startup_splash {
	$_[0]->{startup_splash};
}

sub bin_diff {
	$_[0]->{bin_diff};
}

sub editor_indent_auto {
	$_[0]->{editor_indent_auto};
}

sub editor_indent_tab {
	$_[0]->{editor_indent_tab};
}

sub editor_indent_tab_width {
	$_[0]->{editor_indent_tab_width};
}

sub editor_indent_width {
	$_[0]->{editor_indent_width};
}

sub editor_autoindent {
	$_[0]->{editor_autoindent};
}

sub run_perl_cmd {
	$_[0]->{run_perl_cmd};
}

sub run_use_external_window {
	$_[0]->{run_use_external_window};
}

sub run_interpreter_args_default {
	$_[0]->{run_interpreter_args_default};
}

sub run_script_args_default {
	$_[0]->{run_script_args_default};
}

sub lang_perl5_beginner {
	$_[0]->{lang_perl5_beginner};
}

sub editor_wordwrap {
	$_[0]->{editor_wordwrap};
}

sub default_line_ending {
	$_[0]->{default_line_ending};
}

sub lang_perl5_lexer {
	$_[0]->{lang_perl5_lexer};
}

sub lang_perl5_tags_file {
	$_[0]->{lang_perl5_tags_file};
}

sub file_http_timeout {
	$_[0]->{file_http_timeout};
}

sub file_ftp_timeout {
	$_[0]->{file_ftp_timeout};
}

sub file_ftp_passive {
	$_[0]->{file_ftp_passive};
}

sub preview_refresh {
	$_[0]->main->error('Handler method preview_refresh for event editor_style.OnChoice not implemented');
}

sub guess {
	$_[0]->main->error('Handler method guess for event editor_indent_guess.OnButtonClick not implemented');
}

sub advanced {
	$_[0]->main->error('Handler method advanced for event advanced.OnButtonClick not implemented');
}

sub cancel {
	$_[0]->main->error('Handler method cancel for event cancel.OnButtonClick not implemented');
}

1;

# Copyright 2008-2011 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.

