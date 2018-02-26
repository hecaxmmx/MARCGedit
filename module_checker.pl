
use warnings;
use strict;

print "Testing if necessary modules are installed...\n";

my @modules = (
              'MARC::Record',
              'MARC::Field',
              'MARC::Batch',
              'MARC::File',
              'MARC::File::USMARC',
              'MARC::Lint',
              'MARC::File::MARCMaker',
              'Class::Accessor'
              );


sub try_to_load {
    my $mod = shift;
    eval("use $mod");
    $@ ? return (0) : return (1);
}

foreach my $module (@modules) {
    try_to_load($module) ? print "$module loaded\n" : print "$module not loaded\n";
}

print "\nTesting if some programs exist...\n";

my @programs = (
               'zenity',
               'gedit'
               );

foreach my $program (@programs){
    (-e "/usr/bin/$program" && -x _) ?
            print "$program is installed\n" :
            print "$program is not installed\n";
}

print "\nTesting if libgtksourceview is installed...\n";
print "Using dpkg package manager for Debian...\n\n";

system("dpkg -l 'libgtksourceview*' 2> /dev/null");

print "\n\nNOTE: Packages marked with double i (e.g. ii) mean that the package is installed\n\n";

print "HEADS UP!: If packages are not installed please execute the following command in root superuser\n" .
      " apt-get install libmarc-record-perl libmarc-file-marcmaker-perl libmarc-lint-perl \\\n" .
      "  zenity zenity-common gedit gedit-common gedit-plugins libclass-accessor-perl\n\n";

