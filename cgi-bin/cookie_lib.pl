sub set_cookie {
my ($name, $value, $expiration, $path, $domain, $secure) = @_;
print "Set-Cookie: $name = $value; expires = $expiration; path = $path;
domain = $domain; $secure \n";
return(1);
}
sub get_cookie {
my (@cookies, %return_cookie, $cookie, $key, $val);
@cookies = split (/; /,$ENV{'HTTP_COOKIE'});
foreach $cookie (@cookies){
($key, $val) = split (/=/,$cookie);
$return_cookie{$key} = $val;
}
return (%return_cookie);
}
1;
