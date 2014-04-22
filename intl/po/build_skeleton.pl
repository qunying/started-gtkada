#!/usr/bin/env perl

# 2014-04-16 Zhu Qun-Ying
#   * modified the script to use extract_brackedted from Text::Balanced
#     to take care of nested () or unbalance ) inside the quoting string.
#   * Allow spaces between '-', '(' and '"'.
#   * Add translation of "" inside a string quote. Calls need to be
#     in the form of -(" text "" text ") for it to work.
#   * Add translation for Ada.Characters.Latin1.LF besides ASCII.LF
#   * Only check directories under ../src, don't lookup other places
#   * Make the script more generic and don't hardcode any project
#     specific information. Use parameters for project id, copyright year
#     , owner and bug report.

use strict;
use Text::Balanced 'extract_bracketed';

## If set to 1, all translations are set as empty. Otherwise, the translation
## is the same as the message itself
my ($empty_translation) = 1;

my (%strings);
my (@modules);
my ($msg);

my ($proj_id) = shift;
my ($copyright_year) = shift;
my ($author) = shift;
my ($bug_report) = shift;

# Find the list of modules
sub analyze_dir () {
   my ($dir) = shift;
   local (*DIR);
   opendir (DIR, $dir);
   foreach (readdir (DIR)) {
      if (-d "$dir/$_" && $_ ne '.' && $_ ne '..') {
         push (@modules, "$dir/$_");
         &analyze_dir ("$dir/$_"); 
      }
   }
   close (DIR);
}

push (@modules, "../src");
&analyze_dir ("../src");

# Parse each of their source files

sub get_bracketed {
  my $str = shift;
  my @ret;
  my $bracketed;
  my $ele;

  # loop through all the incoming content
  for ( ; ; ) {
      # seek to beginning of bracket
      return @ret  unless  $str =~ /[^-]*-(?=\s*\(\s*")/gc;
      # get everything from the start brace to the matching end brace
      ($bracketed, $str) = extract_bracketed( $str, '(")');
      # no closing brace found
      return @ret  unless $bracketed;

      # remove the outter () pair
      $ele = substr($bracketed, 1, length ($bracketed) - 2);
      # trim the leading spaces and ", if any
      $ele =~ s/^\s*"//;
      push (@ret, $ele);
  }
}

sub process_modules() {
  local (*DIR, *FILE);
  my ($module, $file, $contents, @matches, $str);

  foreach $module (@modules) {
     opendir (DIR, $module);
     while (($file = readdir(DIR))) {
        if ($file =~ /\.ad[bs]$/) {
           open (FILE, "$module/$file");
           $contents = join ("", <FILE>);

           # Single-line strings
           @matches = ($contents =~ /[^"]-"([^"\n]+)"/gso);
           foreach $str (@matches) {
             ${$strings{$str}}{$file}++; #  .= "$file ";
           }

           # Multi-line strings: we need to concatenate
	   @matches = get_bracketed $contents;
           foreach $str (@matches) {
              $str =~ s/(ASCII\.|Ada\.Characters\.Latin_1\.)?LF/"\\n\"\n  \""/g;
              $str =~ s/"\s*&\s*"//g;
              $str =~ s/"\s*$//g;
	      $str =~ s/""/\\"/g;
              ${$strings{$str}}{$file}++; #  .= "$file ";
           } 
           close (FILE); 
        }
     }

     closedir (DIR);
  }
}


&process_modules;

my ($date) = `date +'%Y-%m-%d %H:%M%z'`;
chomp ($date);

print <<EOF
# Translation file for $proj_id
# Copyright (C) $copyright_year $author
#
msgid ""
msgstr ""
"Project-Id-Version: $proj_id\\n"
"Report-Msgid-Bugs-To: $bug_report\\n"
"POT-Creation-Date: $date\\n"
"PO-Revision-Date: \\n"
"Last-Translator: \\n"
"Language-Team: \\n"
"MIME-Version: 1.0\\n"
"Content-Type: text/plain; charset=UTF-8\\n"
"Content-Transfer-Encoding: 8bit\\n"

EOF
  ;

foreach $msg (sort {uc($a) cmp uc($b)} keys %strings) {
   print "#: ", join (" ", keys %{$strings{$msg}}), "\n";
   print "msgid \"$msg\"\n";
   if ($empty_translation) {
      print "msgstr \"\"\n\n";
   } else {
      print "msgstr \"$msg\"\n\n";
   }
}
