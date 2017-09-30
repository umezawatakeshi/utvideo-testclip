#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip203.vcf") || die;

my $divs = {
	div1  => 0x00000000,
	div8  => 0x00000007,
	div11 => 0x0000000a,
};

my $preds = {
	left   => 0x00000100,
	median => 0x00000300,
};

my $progints = {
	progressive => 0x00000000,
	interlace   => 0x00000800,
};

my $raws0 = [
	{ srcn => "yv24",              ofmt => VDVFMT_YV24,   dstn => "yv24",              sizes => $sizes_444 },
	{ srcn => "yv24-rgb32-bt601",  ofmt => VDVFMT_RGB32,  dstn => "yv24-rgb32-bt601",  sizes => $sizes_444 },
	{ srcn => "yv24-rgb32-bt601",  ofmt => VDVFMT_RGB24,  dstn => "yv24-rgb24-bt601",  sizes => $sizes_444 },
	{ srcn => "yv24-rgb32-bt709",  ofmt => VDVFMT_RGB32,  dstn => "yv24-rgb32-bt709",  sizes => $sizes_444 },
	{ srcn => "yv24-rgb32-bt709",  ofmt => VDVFMT_RGB24,  dstn => "yv24-rgb24-bt709",  sizes => $sizes_444 },
	{ srcn => "yuy2",              ofmt => VDVFMT_UYVY,   dstn => "uyvy",  sizes => $sizes_422 },
	{ srcn => "yuy2",              ofmt => VDVFMT_YUY2,   dstn => "yuy2",  sizes => $sizes_422 },
	{ srcn => "yuy2",              ofmt => VDVFMT_YV16,   dstn => "yv16",  sizes => $sizes_422 },
	{ srcn => "yv12",              ofmt => VDVFMT_YV12,   dstn => "yv12",  sizes => $sizes_420 },
	{ srcn => "yuy2-rgb32-bt601",  ofmt => VDVFMT_RGB32,  dstn => "yuy2-rgb32-bt601",  sizes => $sizes_422 },
	{ srcn => "yuy2-rgb32-bt601",  ofmt => VDVFMT_RGB24,  dstn => "yuy2-rgb24-bt601",  sizes => $sizes_422 },
	{ srcn => "yuy2-rgb32-bt709",  ofmt => VDVFMT_RGB32,  dstn => "yuy2-rgb32-bt709",  sizes => $sizes_422 },
	{ srcn => "yuy2-rgb32-bt709",  ofmt => VDVFMT_RGB24,  dstn => "yuy2-rgb24-bt709",  sizes => $sizes_422 },
];

foreach my $raw (@$raws0) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $sizepair (@{$raw->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		print $FH <<__EOT__;
VirtualDub.Open("clip203-src-$srcn-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip203-raw-$dstn-$size.avi");
__EOT__
	}
}
