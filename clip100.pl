#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip100.vcf") || die;

my $raws0 = [
	{ srcn => "yuy2",  ofmt => VDVFMT_UYVY,  dstn => "uyvy",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YV16,  dstn => "yv16",  sizes => $sizes_422 },
];

my $raws1 = [
	{ srcn => "yuy2-yv12",       ofmt => VDVFMT_YV12,  dstn => "yuy2-yv12",       sizes => $sizes_420, sizes_int => $sizes_420_int },
	{ srcn => "yuy2-yv12-yuy2",  ofmt => VDVFMT_UYVY,  dstn => "yuy2-yv12-uyvy",  sizes => $sizes_420, sizes_int => $sizes_420_int },
	{ srcn => "yuy2-yv12-yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2-yv12-yuy2",  sizes => $sizes_420, sizes_int => $sizes_420_int },
	{ srcn => "yuy2-yv12-yuy2",  ofmt => VDVFMT_YV16,  dstn => "yuy2-yv12-yv16",  sizes => $sizes_420, sizes_int => $sizes_420_int },
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
VirtualDub.Open("clip100-src-$srcn-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip100-raw-$dstn-$size.avi");
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
VirtualDub.Open("clip100-src-$srcn-$progint-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip100-raw-$dstn-$progint-$size.avi");
__EOT__
		}
	}
}

print $FH <<__EOT__;
VirtualDub.video.filters.Clear();
__EOT__

my $ulxx_comps = [
	{ fourcc => "uly0", srcn => "yuy2",  sizes => $ulxx_sizes_420, sizes_int => $ulxx_sizes_420_int },
	{ fourcc => "ulh0", srcn => "yuy2",  sizes => $ulxx_sizes_420, sizes_int => $ulxx_sizes_420_int },
];

foreach my $comp (@$ulxx_comps) {
	my $fourcc = $comp->{fourcc};
	my $srcn = $comp->{srcn};
	foreach my $progint (sort(keys(%$ulxx_progints))) {
		foreach my $sizepair ($progint eq "progressive" ? @{$comp->{sizes}} : @{$comp->{sizes_int}}) {
			my $width  = $sizepair->[0];
			my $height = $sizepair->[1];
			my $size = $width . "x" . $height;
			foreach my $div (sort(keys(%$ulxx_divs))) {
				foreach my $pred (sort(keys(%$ulxx_preds))) {
					my $confval = $ulxx_divs->{$div} | $ulxx_preds->{$pred} | $ulxx_progints->{$progint};
					my $confstr = pack("V", $confval);
					my $confb64 = encode_base64($confstr, "");
					print $FH <<__EOT__;
VirtualDub.Open("clip100-raw-$srcn-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip100-$fourcc-$progint-$pred-$div-$size.avi");
__EOT__
				}
			}
		}
	}
}
