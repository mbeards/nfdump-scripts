#!/usr/bin/perl

#nfdump 6-hour report 

use DateTime;
use POSIX qw/strftime/;



#add channels here
my $channels = join(':',""); 

my $start = DateTime->now(time_zone => "America/Los_Angeles")->subtract( hours => 6 );
my $end = DateTime->now(time_zone => "America/Los_Angeles");

my $hourpad = $start->hour;
if ($hourpad < 10) {
  $hourpad = "0".$hourpad;
} 

my $minutepad = $start->minute - ($start->minute %5);
if($minutepad < 10) {
  $minutepad = "0".$minutepad;
}

my $startpath = $start->ymd("/")."/nfcapd.".$start->ymd("").$hourpad.$minutepad;

$hourpad = $end->hour;
if ($hourpad < 10) {
  $hourpad = "0".$hourpad;
} 
$minutepad = $end->minute - (5+ $end->minute % 5);
if($minutepad < 10) {
  $minutepad = "0".$minutepad;
}

my $endpath = $end->ymd("/")."/nfcapd.".$end->ymd("").$hourpad.$minutepad;

my $nbytescommand = "/usr/local/bin/nfdump -M /usr/local/nfsen/profiles-data/live/$channels -R $startpath:$endpath -n 30 -s srcip/bytes &";
my $npacketscommand = "/usr/local/bin/nfdump -M /usr/local/nfsen/profiles-data/live/$channels -R $startpath:$endpath -n 30 -s srcip/packets &";

