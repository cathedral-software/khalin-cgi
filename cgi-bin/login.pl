#!/usr/bin/perl
print "Content-type: text/html\n\n";
print"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n";
print "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n";
print "<head>\n";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n";
print "<link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />\n";
print "<title>Login</title>\n";
print "</head>\n";
print "<body>\n";
print "<h1>Login to our server</h1>\n";
#Read the data
read(STDIN, $FormData, $ENV{'CONTENT_LENGTH'});
my @pairs = split(/&/, $FormData);
foreach $pair (@pairs)
{
  my ($name, $value) = split(/=/, $pair);
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $FORM{$name} = $value;
}
unless ($FORM{'user'}) {
	print "<p>You didn't enter any username...</p>\n";
	exit(0);
}
if ((lc($FORM{'user'}) eq "anonymous") or (lc($FORM{'user'}) eq "anonus")) {
	print "<p>You logged in as an Anonymous User!</p>\n";
	exit(0);
}
unless ($FORM{'pass'}) {
	print "<p>You didn't enter any password...</p>\n";
	exit(0);
}
if (lc($FORM{'user'}) eq 'tomeu') {
	if (lc($FORM{'pass'}) ne 'openaccess') {
	print "<p>Invalid password!</p>\n";
	} else {
	print "<p>Welcome, Tomeu!</p>\n";
	}
} elsif (lc($FORM{'user'}) eq 'khalin') {
	if (lc($FORM{'pass'}) ne 'openaccess2') {
	print "<p>Invalid password!</p>\n";
	} else {
	print "<p>Welcome to the server, Khalin!</p>\n";
	}
} else {
	print "<p>Invalid user!</p>\n";
}
print "</body>\n";
print "</html>\n";
