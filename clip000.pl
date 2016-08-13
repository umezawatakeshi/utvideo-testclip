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

my $sizes_444 = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
my $sizes_422 = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
my $sizes_420 = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 254 ],               [ 384, 512 ] ];

my $sizes_444_int = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 254 ], [ 384, 512 ] ];
my $sizes_422_int = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 254 ], [ 384, 512 ] ];
my $sizes_420_int = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 512 ] ];

my $raws = [
	{ srcn => "rgb24", ofmt => VDVFMT_RGB24, dstn => "rgb24", sizes => $sizes_444 },
	{ srcn => "rgb32", ofmt => VDVFMT_RGB32, dstn => "rgb32", sizes => $sizes_444 },
	{ srcn => "rgba",  ofmt => VDVFMT_RGB32, dstn => "rgba",  sizes => $sizes_444 },
	{ srcn => "yuv",   ofmt => VDVFMT_YV24,  dstn => "yv24",  sizes => $sizes_444 },
	{ srcn => "yuv",   ofmt => VDVFMT_UYVY,  dstn => "uyvy",  sizes => $sizes_422 },
	{ srcn => "yuv",   ofmt => VDVFMT_YUY2,  dstn => "yuy2",  sizes => $sizes_422 },
	{ srcn => "yuv",   ofmt => VDVFMT_YV12,  dstn => "yv12",  sizes => $sizes_420 },
];

foreach my $raw (@$raws) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $sizepair (@{$raw->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		print <<__EOT__;
VirtualDub.Open("clip000-src-$srcn-384x256.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("resize");
VirtualDub.video.filters.instance[0].Config($width, $height, 0);
VirtualDub.SaveAVI("clip000-raw-$dstn-$size.avi");
__EOT__
	}
}

my $comps = [
	{ fourcc => "ulrg", srcn => "rgb24", sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ fourcc => "ulra", srcn => "rgba",  sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ fourcc => "uly2", srcn => "yuy2",  sizes => $sizes_422, sizes_int => $sizes_422_int },
	{ fourcc => "uly0", srcn => "yv12",  sizes => $sizes_420, sizes_int => $sizes_420_int },
	{ fourcc => "ulh2", srcn => "yuy2",  sizes => $sizes_422, sizes_int => $sizes_422_int },
	{ fourcc => "ulh0", srcn => "yv12",  sizes => $sizes_420, sizes_int => $sizes_420_int },
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
		foreach my $sizepair ($progint eq "progressive" ? @{$comp->{sizes}} : @{$comp->{sizes_int}}) {
			my $width  = $sizepair->[0];
			my $height = $sizepair->[1];
			my $size = $width . "x" . $height;
			foreach my $div (sort(keys(%$divs))) {
				foreach my $pred (sort(keys(%$preds))) {
					my $confval = $divs->{$div} | $preds->{$pred} | $progints->{$progint};
					my $confstr = pack("V", $confval);
					my $confb64 = encode_base64($confstr, "");
					print <<__EOT__;
VirtualDub.Open("clip000-raw-$srcn-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("resize");
VirtualDub.video.filters.instance[0].Config($width, $height, 0);
VirtualDub.SaveAVI("clip000-$fourcc-$progint-$pred-$div-$size.avi");
__EOT__
				}
			}
		}
	}
}