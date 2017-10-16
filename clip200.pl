#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip200.vcf") || die;

my $raws0 = [
	{ srcn => "rgb32",  ofmt => VDVFMT_RGB32,  dstn => "rgb32",  sizes => $sizes_444 },
	{ srcn => "rgb32",  ofmt => VDVFMT_RGB24,  dstn => "rgb24",  sizes => $sizes_444 },
	{ srcn => "yv24-bt601",  ofmt => VDVFMT_YV24,  dstn => "yv24-bt601",  sizes => $sizes_444 },
	{ srcn => "yv24-bt709",  ofmt => VDVFMT_YV24,  dstn => "yv24-bt709",  sizes => $sizes_444 },
	{ srcn => "yuy2-bt601",  ofmt => VDVFMT_UYVY,  dstn => "uyvy-bt601",  sizes => $sizes_422 },
	{ srcn => "yuy2-bt601",  ofmt => VDVFMT_YUY2,  dstn => "yuy2-bt601",  sizes => $sizes_422 },
	{ srcn => "yuy2-bt601",  ofmt => VDVFMT_YV16,  dstn => "yv16-bt601",  sizes => $sizes_422 },
	{ srcn => "yuy2-bt709",  ofmt => VDVFMT_UYVY,  dstn => "uyvy-bt709",  sizes => $sizes_422 },
	{ srcn => "yuy2-bt709",  ofmt => VDVFMT_YUY2,  dstn => "yuy2-bt709",  sizes => $sizes_422 },
	{ srcn => "yuy2-bt709",  ofmt => VDVFMT_YV16,  dstn => "yv16-bt709",  sizes => $sizes_422 },
];

my $raws1 = [
	{ srcn => "yv12-bt601",  ofmt => VDVFMT_YV12,  dstn => "yv12-bt601",  sizes => $sizes_420, sizes_int => $sizes_420_int },
	{ srcn => "yv12-bt709",  ofmt => VDVFMT_YV12,  dstn => "yv12-bt709",  sizes => $sizes_420, sizes_int => $sizes_420_int },
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
VirtualDub.Open("clip200-src-$srcn-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip200-raw-$dstn-$size.avi");
__EOT__
	}
}

foreach my $raw (@$raws1) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $progint (sort(keys(%$ulxx_progints))) {
		foreach my $sizepair ($progint eq "progressive" ? @{$raw->{sizes}} : @{$raw->{sizes_int}}) {
			my $width  = $sizepair->[0];
			my $height = $sizepair->[1];
			my $size = $width . "x" . $height;
			print $FH <<__EOT__;
VirtualDub.Open("clip200-src-$srcn-$progint-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip200-raw-$dstn-$progint-$size.avi");
__EOT__
		}
	}
}
