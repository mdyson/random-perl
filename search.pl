#!/usr/bin/perl -w
# search.pl

use strict;
use Cwd;

print "Enter your query to search this dir: ";
my $query = <STDIN>;
chomp($query);

my $dirName = cwd();
my $count = 0;

opendir(DIR, $dirName) or die "can't opendir $dirName: $!";

while (my $file = readdir(DIR)) {
	#print "Reading ".$file."\n";
	open (FILE, $file);
	$_ = join('',<FILE>);
			
	while ($_ =~ /$query/gis) {
	        print "Found: $query\n";
        	$count++;
	}
	
	close (FILE);
}

if($count > 0) {
	print "Found ".$count." occurances of ".$query.".\n";
}
else {
	print "Did not find ".$query." in this directory.\n";
}
