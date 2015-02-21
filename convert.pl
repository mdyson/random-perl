#!/usr/bin/perl -w
#This file will take in a text file from the listserv that is formatted as
#EMAIL {some arbitrary amount of spaces} NAME and convert it into a csv file
#because the listserv is incapable of doing such a simple task for us.

use strict;

#open the files
open SOURCE,"<", "list.txt" or die $!;
open DEST,"+>", "list.csv" or die $!;

#declare varaibles
my ($line,$out,$offset,$name,$firstName,$lastName,$email,$firstSpace,$nextSpace,$lastSpace);

#print out the header line to the csv file
print DEST "\"Last Name\",\"First Name\",\"Email\"\n";

#loop through each line of the rest of the file
while (<SOURCE>) {
        chomp;
	$line = $_;
	
	#find the first occurance of a space, this will tell us
	#when to stop reading the email address
	$firstSpace = index($line, " ");
	
	#find the last occurance of a space before it starts printing 
	#out the name.
	#
	#this will only give the last name because it finds the last space
	#$lastSpace = rindex($line, " "); 
	$nextSpace = " ";
	$lastSpace = -1;
	#loop through all of the spaces until the next character is 
	#not a space, this is where the first name begins
	while ($nextSpace eq " ") {
		$offset = $lastSpace + 1;
		$lastSpace = index($line, " ",$offset);
		$nextSpace = substr $line,$lastSpace+1,1;
	}
	
	#find the substrings of the email and name and store
	#only that into its own stringstring
	$email = substr $line, 0, $firstSpace;
	$name = substr $line, $lastSpace+1;
	
	$lastSpace = index($name, " ",0);
	$firstName = substr $name, 0, $lastSpace;
	$lastName = substr $name, $lastSpace+1;
	
	#format out the line that will be inserted into the csv file
	$out = sprintf("\"%s\",\"%s\",\"%s\"\n",$lastName,$firstName,$email);
	
	#write it to the file
	print DEST $out;
}
