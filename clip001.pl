#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

# video formats (for video.SetInputFormat/SetOutputFormat)
sub VDVFMT_AUTO()  {  0 }
sub VDVFMT_RGB15() {  5 }
sub VDVFMT_RGB16() {  6 }
sub VDVFMT_RGB24() {  7 }
sub VDVFMT_RGB32() {  8 }
sub VDVFMT_Y8()    {  9 }
sub VDVFMT_UYVY()  { 10 }
sub VDVFMT_YUY2()  { 11 }
sub VDVFMT_YV24()  { 13 }
sub VDVFMT_YV16()  { 14 }
sub VDVFMT_YV12()  { 15 }
sub VDVFMT_YVU9()  { 17 }

# video modes (for video.GetMode/SetMode)
sub VDVMODE_DIRECT() { 0 }
sub VDVMODE_FAST()   { 1 }
sub VDVMODE_SLOW()   { 2 }
sub VDVMODE_FULL()   { 3 }

my $raws = [
	{ srcn => "rgb32", ofmt => VDVFMT_RGB24, dstn => "rgb24" },
	{ srcn => "rgb32", ofmt => VDVFMT_RGB32, dstn => "rgb32" },
	{ srcn => "rgba",  ofmt => VDVFMT_RGB32, dstn => "rgba"  },
	{ srcn => "yv24",  ofmt => VDVFMT_YV24,  dstn => "yv24"  },
	{ srcn => "yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2"  },
	{ srcn => "yv12",  ofmt => VDVFMT_YV12,  dstn => "yv12"  },
];

foreach my $raw (@$raws) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	print <<__EOT__;
VirtualDub.Open("clip001-src-$srcn.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.SaveAVI("clip001-raw-$dstn-384x256.avi");
__EOT__
}

my $comps = [
	{ fourcc => "ulrg", srcn => "rgb24" },
	{ fourcc => "ulra", srcn => "rgba" },
	{ fourcc => "uly2", srcn => "yuy2" },
	{ fourcc => "uly0", srcn => "yv12" },
	{ fourcc => "ulh2", srcn => "yuy2" },
	{ fourcc => "ulh0", srcn => "yv12" },
];

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

foreach my $comp (@$comps) {
	my $fourcc = $comp->{fourcc};
	my $srcn = $comp->{srcn};
	foreach my $progint (sort(keys(%$progints))) {
		foreach my $div (sort(keys(%$divs))) {
			foreach my $pred (sort(keys(%$preds))) {
				my $confval = $divs->{$div} | $preds->{$pred} | $progints->{$progint};
				my $confstr = pack("V", $confval);
				my $confb64 = encode_base64($confstr, "");
				print <<__EOT__;
VirtualDub.Open("clip001-raw-$srcn-384x256.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip001-$fourcc-$progint-$pred-$div-384x256.avi");
__EOT__
			}
		}
	}
}
