#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

use Math::Random qw(random_binomial random_uniform_integer);
use LWP::UserAgent;


my @words = qw/a b c d e f g h i g k l m n o p q r s t u v w x y z A B C D E F G H I G K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9/;


foreach (@ARGV) {
	my $id = $_;

	my $time = time;

	my $i = 1;
	while () {

		my $key;

		my @keyc = random_uniform_integer(6,0,61);

		foreach (@keyc) {
			$key .= $words[$_];
		}

		my $url = "https://sscn.afast.ws/$id/$key/main.m3u8";

		my $status = &test_url($url);

		if ($status eq '200 OK') {

			open (my $OUTPUT, ">valid_url_".time) || die $!;
			say $OUTPUT "Test times: $i";
			say $OUTPUT "$url\n";
			close $OUTPUT;

			last;
		}else{
			open (my $OUTPUT2, ">log_".$time) || die $!;
			say $OUTPUT2 "\t$i\t$key\t$status\t$id\t".(56800235584 - $i);
			close $OUTPUT2;
		}

		$i++;
	}

}










sub test_url {
	my ($url) = @_;

	my $ua = LWP::UserAgent->new;
	$ua->agent('Mozilla/5.0');
	$ua->cookie_jar({});

	my $response = $ua->get( $url );

	return $response->status_line;
}

