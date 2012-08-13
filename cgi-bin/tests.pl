#!/opt/lampp/bin/perl
print "Content-type: text/html\n\n";
print"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
print "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n";
print "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n";
print "<head>\n";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n";
print "<link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />\n";
print "<title>Tomeu's Page</title>\n";
print "</head>\n";
print "<body>\n";
print "<p>Hello, world. I'm <strong>Sid</strong>.</p>\n";
if (length ($ENV{'QUERY_STRING'}) > 0){
      $buffer = $ENV{'QUERY_STRING'};
      @pairs = split(/&/, $buffer);
      foreach $pair (@pairs){
           ($name, $value) = split(/=/, $pair);
           $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
           $value =~ s/\+/ /g;
	   $in{$name} = $value; 
      }
 }
if ($in{'name'}) {
print "<p>Your name is " . $in{'name'} . ".</p>";
}
if ($in{'bf'}) {
print "<p>Your best friend is " . $in{'bf'} . ".</p>";
}
if ($in{'pf'}) {
print "<p>You come from " . $in{'pf'} . ".</p>";
}
print "</body>\n";
print "</html>\n";
