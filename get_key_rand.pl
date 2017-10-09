#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

use Math::Random qw(random_binomial random_uniform_integer);
use LWP::UserAgent;


my @words = qw/a b c d e f g h i g k l m n o p q r s t u v w x y z A B C D E F G H I G K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9/;


my ($ua, $key, @keyc, $url, $response, $status, $OUTPUT, $OUTPUT2);

foreach (@ARGV) {
	my $id = $_;

	my $time = time;

	my $i = 1;
	while () {

                undef @keyc;
	        @keyc = random_uniform_integer(6,0,61);

                undef $key;

		foreach (@keyc) {
			$key .= $words[$_];
		}

                undef $url;
		$url = "https://sscn.afast.ws/$id/$key/main.m3u8";

                undef $ua;
                $ua = LWP::UserAgent->new;
                $ua->agent('Mozilla/5.0');

                undef $response;
                $response = $ua->get( $url );

                undef $status;
                $status = $response->status_line;

		if ($status eq '200 OK') {

		        open ($OUTPUT, ">valid_url_".time) || die $!;
			say $OUTPUT "Test times: $i";
			say $OUTPUT "$url\n";
			close $OUTPUT;

			die;
		}else{
			open ($OUTPUT2, ">log_".$time) || die $!;
			say $OUTPUT2 "\t$i\t$key\t$status\t$id\t".(56800235584 - $i);
			close $OUTPUT2;
		}

		$i++;
	}

}


