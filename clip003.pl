#!/usr/bin/perl

BEGIN { push(@INC, "."); }

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip003.vcf") || die;

my $raws = [
	{ srcn => "rgb24", ofmt => VDVFMT_RGB24, dstn => "rgb24", sizes => $sizes_444 },
	{ srcn => "rgb32", ofmt => VDVFMT_RGB32, dstn => "rgb32", sizes => $sizes_444 },
	{ srcn => "rgba",  ofmt => VDVFMT_RGB32, dstn => "rgba",  sizes => $sizes_444 },
	{ srcn => "yv24",  ofmt => VDVFMT_YV24,  dstn => "yv24",  sizes => $sizes_444 },
	{ srcn => "yuy2",  ofmt => VDVFMT_UYVY,  dstn => "uyvy",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YV16,  dstn => "yv16",  sizes => $sizes_422 },
];

foreach my $raw (@$raws) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $sizepair (@{$raw->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		foreach my $div (sort(keys(%$umxx_divs))) {
			open(my $AVS, ">clip003-src-$srcn-div$div-$size.avs") || die $!;
			open(my $AVSSRC, "<clip003-src-$srcn.avs") || die "$srcn: $!";
			print $AVS <<__EOT__;
div=$div
width=$width
height=$height
__EOT__
			@_ = <$AVSSRC>;
			print $AVS @_;
			close($AVSSRC);
			close($AVS);
			print $FH <<__EOT__;
VirtualDub.Open("clip003-src-$srcn-div$div-$size.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.SaveAVI("clip003-raw-$dstn-div$div-$size.avi");
__EOT__
		}
	}
}

print $FH <<__EOT__;
VirtualDub.video.filters.Clear();
__EOT__

my $umxx_comps = [
	{ fourcc => "umrg", srcn => "rgb24", sizes => $umxx_sizes_444 },
	{ fourcc => "umra", srcn => "rgba",  sizes => $umxx_sizes_444 },
	{ fourcc => "umy4", srcn => "yv24",  sizes => $umxx_sizes_444 },
	{ fourcc => "umy2", srcn => "yuy2",  sizes => $umxx_sizes_422 },
	{ fourcc => "umh4", srcn => "yv24",  sizes => $umxx_sizes_444 },
	{ fourcc => "umh2", srcn => "yuy2",  sizes => $umxx_sizes_422 },
];

foreach my $comp (@$umxx_comps) {
	my $fourcc = $comp->{fourcc};
	my $srcn = $comp->{srcn};
	foreach my $sizepair (@{$comp->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		foreach my $div (sort(keys(%$umxx_divs))) {
			my $confval = $umxx_divs->{$div} | $umxx_k3;
			my $confstr = pack("V", $confval);
			my $confb64 = encode_base64($confstr, "");
			print $FH <<__EOT__;
VirtualDub.Open("clip003-raw-$srcn-div$div-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip003-$fourcc-div$div-$size.avi");
__EOT__
		}
	}
}
