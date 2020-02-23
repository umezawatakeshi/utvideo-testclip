#!/usr/bin/perl

BEGIN { push(@INC, "."); }

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip001.vcf") || die;

my $raws = [
	{ srcn => "rgb24", ofmt => VDVFMT_RGB24, dstn => "rgb24", sizes => $sizes_444 },
	{ srcn => "rgb32", ofmt => VDVFMT_RGB32, dstn => "rgb32", sizes => $sizes_444 },
	{ srcn => "rgba",  ofmt => VDVFMT_RGB32, dstn => "rgba",  sizes => $sizes_444 },
	{ srcn => "yv24",  ofmt => VDVFMT_YV24,  dstn => "yv24",  sizes => $sizes_444 },
	{ srcn => "yuy2",  ofmt => VDVFMT_UYVY,  dstn => "uyvy",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2",  sizes => $sizes_422 },
	{ srcn => "yuy2",  ofmt => VDVFMT_YV16,  dstn => "yv16",  sizes => $sizes_422 },
	{ srcn => "yv12",  ofmt => VDVFMT_YV12,  dstn => "yv12",  sizes => $sizes_420 },
	{ srcn => "rgb10bit",   ofmt => VDVFMT_r210, dstn => "rgb10bit_r210",   sizes => $sizes_444 },
	{ srcn => "rgb10bit",   ofmt => VDVFMT_b64a, dstn => "rgb10bit_b64a",   sizes => $sizes_444 },
	{ srcn => "rgb10bitn",  ofmt => VDVFMT_b64a, dstn => "rgb10bitn_b64a",  sizes => $sizes_444 },
	{ srcn => "rgba10bit",  ofmt => VDVFMT_b64a, dstn => "rgba10bit_b64a",  sizes => $sizes_444 },
	{ srcn => "rgba10bitn", ofmt => VDVFMT_b64a, dstn => "rgba10bitn_b64a", sizes => $sizes_444 },
	{ srcn => "yuv10bit",   ofmt => VDVFMT_v210, dstn => "yuv10bit_v210",   sizes => $sizes_422 },
	{ srcn => "yuv10bit",   ofmt => VDVFMT_YUV422P16LE, dstn => "yuv10bit_yuv422p16le",   sizes => $sizes_422 },
	{ srcn => "yuv10bitn",  ofmt => VDVFMT_YUV422P16LE, dstn => "yuv10bitn_yuv422p16le",  sizes => $sizes_422 },
];

foreach my $raw (@$raws) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $sizepair (@{$raw->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		print $FH <<__EOT__;
VirtualDub.Open("clip001-src-$srcn-384x512.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.video.filters.Add("null transform");
VirtualDub.video.filters.instance[0].SetClipping(0, 0, 384-$width, 512-$height);
VirtualDub.SaveAVI("clip001-raw-$dstn-$size.avi");
__EOT__
	}
}

print $FH <<__EOT__;
VirtualDub.video.filters.Clear();
__EOT__

my $ulxx_comps = [
	{ fourcc => "ulrg", srcn => "rgb24", sizes => $ulxx_sizes_444, sizes_int => $ulxx_sizes_444_int },
	{ fourcc => "ulra", srcn => "rgba",  sizes => $ulxx_sizes_444, sizes_int => $ulxx_sizes_444_int },
	{ fourcc => "uly4", srcn => "yv24",  sizes => $ulxx_sizes_444, sizes_int => $ulxx_sizes_444_int },
	{ fourcc => "uly2", srcn => "yuy2",  sizes => $ulxx_sizes_422, sizes_int => $ulxx_sizes_422_int },
	{ fourcc => "uly0", srcn => "yv12",  sizes => $ulxx_sizes_420, sizes_int => $ulxx_sizes_420_int },
	{ fourcc => "ulh4", srcn => "yv24",  sizes => $ulxx_sizes_444, sizes_int => $ulxx_sizes_444_int },
	{ fourcc => "ulh2", srcn => "yuy2",  sizes => $ulxx_sizes_422, sizes_int => $ulxx_sizes_422_int },
	{ fourcc => "ulh0", srcn => "yv12",  sizes => $ulxx_sizes_420, sizes_int => $ulxx_sizes_420_int },
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
VirtualDub.Open("clip001-raw-$srcn-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip001-$fourcc-$progint-$pred-div$div-$size.avi");
__EOT__
				}
			}
		}
	}
}

my $uqxx_comps = [
	{ fourcc => "uqrg", srcn => "rgb10bit_b64a",  sizes => $uqxx_sizes_444 },
	{ fourcc => "uqra", srcn => "rgba10bit_b64a", sizes => $uqxx_sizes_444 },
	{ fourcc => "uqy2", srcn => "yuv10bit_v210",  sizes => $uqxx_sizes_422 },
];

foreach my $comp (@$uqxx_comps) {
	my $fourcc = $comp->{fourcc};
	my $srcn = $comp->{srcn};
	foreach my $sizepair (@{$comp->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		foreach my $div (sort(keys(%$uqxx_divs))) {
			foreach my $pred (sort(keys(%$uqxx_preds))) {
				my $confval = $uqxx_divs->{$div} | $uqxx_preds->{$pred};
				my $confstr = pack("V", $confval);
				my $confb64 = encode_base64($confstr, "");
				print $FH <<__EOT__;
VirtualDub.Open("clip001-raw-$srcn-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip001-$fourcc-$pred-div$div-$size.avi");
__EOT__
			}
		}
	}
}

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
			my $confval = $umxx_divs->{$div};
			my $confstr = pack("V", $confval);
			my $confb64 = encode_base64($confstr, "");
			print $FH <<__EOT__;
VirtualDub.Open("clip001-raw-$srcn-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip001-$fourcc-div$div-$size.avi");
__EOT__
		}
	}
}
