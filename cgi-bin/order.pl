#!/opt/lampp/bin/perl
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
print "<h1>Order Results</h1>\n<hr />\n";
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
if ($FORM{'amadeus'} ne 'on' and $FORM{'emperor'} ne 'on' and $FORM{'gandhi'} ne 'on' and $FORM{'schindler'} ne 'on') {
	print "<p>Error! You didn't select any movie!</p>\n";
} else {
	print "<p>You selected the following movies:</p>\n<ul>\n";
	if ($FORM{'amadeus'} eq 'on') { print "<li>Amadeus</li>\n"; }
	if ($FORM{'emperor'} eq 'on') { print "<li>The Last Emperor</li>\n"; }
	if ($FORM{'gandhi'} eq 'on') { print "<li>Gandhi</li>\n"; }
	if ($FORM{'schindler'} eq 'on') { print "<li>The Schindler's list</li>\n"; }
	print "</ul>\n<p>You'll pay with ".$FORM{'payment'}.".</p>\n";
	my $range = 999999999;
  	my $minimum = 1;
 	my $ticket = int(rand($range)) + $minimum;
	print "<p>Your ticket is <strong>".$ticket."</strong>.</p>";
}
print "</body>\n";
print "</html>\n";
