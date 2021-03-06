#!/usr/bin/perl
use GD;
$| = 1;
$webmaster = "tomeuari\@gmail\.com";
$exclusive_lock = 2;
$unlock_lock = 8;
$counter_file = "/opt/lampp/htdocs/count.txt";
$no_visitors = 1;
if (! (-e $counter_file)) {
	if (open (COUNTER, ">" . $counter_file)) {
		flock (COUNTER, $exclusive_lock);
		print COUNTER $no_visitors;
		flock (COUNTER, $unlock_lock);
		close (COUNTER);
	} else {
		&return_error (500, "Counter Error", "Cannot create ata file to store counter information.");
	} 
} else {
	if (! ((-r $counter_file) && (-w $counter_file)) ) {
		&return_error (500, "Counter Error", "Cannot read or write the counter data file.");
	} else {
		open(COUNTER,  "<" . $counter_file);
		flock (COUNTER, $exclusive_lock);
		$no_visitors = <COUNTER>;
		flock (COUNTER, $unlock_lock);
		close (COUNTER);
		$no_visitors++;
		open (COUNTER, ">" . $counter_file);
		flock (COUNTER, $exclusive_lock);
		print COUNTER $no_visitors;
		flock (COUNTER, $unlock_lock);
		close (COUNTER);
  	}
}
&graphic_counter();
exit(0);

sub graphic_counter {
	local ( $count_length, $font_length, $font_height, $distance,
    $border, $image_length, $image_height, $image, $black, $blue, $red,
    $loop, $number, $temp_x);
	$count_length = length ($no_visitors);
	$font_length = 8;
	$font_height = 16;
	$distance = 3;
	$border = 4;
	$image_length = ($count_length * $font_length) +
			(($count_length - 1) * distance) + $border;
	$image_height = $font_height + $boder;
	$image = new GD::Image ($image_length, $image_height);
	$black = $image->colorAllocate (0, 0, 0);
   	$blue = $image->colorAllocate (0, 0, 255);
   	$red = $image->colorAllocate (255, 0, 0);
   	$image->rectangle (0, 0, $image_length - 1, $image_height - 1, $blue);
	for ($loop=0; $loop <= ($count_length - 1); $loop++) {
		$number = substr ($no_visitors, $loop, 1);
		if ($count_length > 1) {
          		$temp_x = ($font_length + $distance) * ($loop + 1);
         		$image->line (  $temp_x,
                         		0,
                          		$temp_x,
                          		$image_height,
                          		$blue  );
     		}
 		$image->char ( gdLargeFont, 
                	($border / 2) + ($font_length * $loop) + 
                    	($loop * $distance),
                  	$distance, 
                  	$number, 
                  	$red  );
    }
print "Content-type: image/gif", "\n\n";
    print $image->gif;
}
sub return_error
{
    local ($status, $keyword, $message) = @_;
    print "Content-type: text/html", "\n";
    print "Status: ", $status, " ", $keyword, "\n\n";
    print <<End_of_Error;
<HTML>
<HEAD>
    <TITLE>CGI Program - Unexpected Error</TITLE>
</HEAD>
<BODY>
<H1>$keyword</H1>
<HR>$message<HR>
Please contact $webmaster for more information.
</BODY>
</HTML>
End_of_Error
    exit(1);
}
