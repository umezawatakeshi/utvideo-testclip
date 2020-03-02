#!/usr/bin/perl

BEGIN { push(@INC, "."); }

use strict;
use warnings;

use MIME::Base64;

use Defs;

open(my $FH, ">clip002.vcf") || die;

my $raws = [
	{ srcn => "rgb24", ofmt => VDVFMT_RGB24, dstn => "rgb24", sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ srcn => "rgb32", ofmt => VDVFMT_RGB32, dstn => "rgb32", sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ srcn => "rgba",  ofmt => VDVFMT_RGB32, dstn => "rgba",  sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ srcn => "yv24",  ofmt => VDVFMT_YV24,  dstn => "yv24",  sizes => $sizes_444, sizes_int => $sizes_444_int },
	{ srcn => "yuy2",  ofmt => VDVFMT_UYVY,  dstn => "uyvy",  sizes => $sizes_422, sizes_int => $sizes_422_int },
	{ srcn => "yuy2",  ofmt => VDVFMT_YUY2,  dstn => "yuy2",  sizes => $sizes_422, sizes_int => $sizes_422_int },
	{ srcn => "yuy2",  ofmt => VDVFMT_YV16,  dstn => "yv16",  sizes => $sizes_422, sizes_int => $sizes_422_int },
	{ srcn => "yv12",  ofmt => VDVFMT_YV12,  dstn => "yv12",  sizes => $sizes_420, sizes_int => $sizes_420_int },
];

foreach my $raw (@$raws) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $progint (sort(keys(%$ulxx_progints))) {
		foreach my $sizepair ($progint eq "progressive" ? @{$raw->{sizes}} : @{$raw->{sizes_int}}) {
			my $width  = $sizepair->[0];
			my $height = $sizepair->[1];
			my $size = $width . "x" . $height;
			foreach my $div (sort(keys(%$ulxx_divs))) {
				foreach my $pred (sort(keys(%$ulxx_preds))) {
					open(my $AVS, ">clip002-src-$srcn-$progint-$pred-div$div-$size.avs") || die $!;
					open(my $AVSSRC, "<clip002-src-$srcn.avs") || die "$srcn: $!";
					print $AVS <<__EOT__;
progint="$progint"
pred="$pred"
div=$div
width=$width
height=$height
__EOT__
					@_ = <$AVSSRC>;
					print $AVS @_;
					close($AVSSRC);
					close($AVS);
					print $FH <<__EOT__;
VirtualDub.Open("clip002-src-$srcn-$progint-$pred-div$div-$size.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.SaveAVI("clip002-raw-$dstn-$progint-$pred-div$div-$size.avi");
__EOT__
				}
			}
		}
	}
}

my $raws_hbd = [ 
	{ srcn => "rgb10bit",    ofmt => VDVFMT_r210, dstn => "rgb10bit_r210",  sizes => $sizes_444 },
	{ srcn => "rgb10bit",    ofmt => VDVFMT_b64a, dstn => "rgb10bit_b64a",  sizes => $sizes_444 },
	{ srcn => "rgba10bit",   ofmt => VDVFMT_b64a, dstn => "rgba10bit_b64a", sizes => $sizes_444 },
	{ srcn => "yuv42210bit", ofmt => VDVFMT_v210, dstn => "yuv10bit_v210",  sizes => $sizes_422 },
	{ srcn => "yuv42210bit", ofmt => VDVFMT_P210, dstn => "yuv10bit_p210",  sizes => $sizes_422 },
	{ srcn => "yuv42210bit", ofmt => VDVFMT_P216, dstn => "yuv10bit_p216",  sizes => $sizes_422 },
	{ srcn => "yuv42210bit", ofmt => VDVFMT_YUV422P16LE, dstn => "yuv10bit_yuv422p16le",  sizes => $sizes_422 },
	{ srcn => "yuv42010bit", ofmt => VDVFMT_P010, dstn => "yuv10bit_p010",  sizes => $sizes_420 },
	{ srcn => "yuv42010bit", ofmt => VDVFMT_P016, dstn => "yuv10bit_p016",  sizes => $sizes_420 },
	{ srcn => "yuv42010bit", ofmt => VDVFMT_YUV420P16LE, dstn => "yuv10bit_yuv420p16le",  sizes => $sizes_420 },
];

foreach my $raw (@$raws_hbd) {
	my $srcn = $raw->{srcn};
	my $dstn = $raw->{dstn};
	my $ofmt = $raw->{ofmt};
	foreach my $sizepair (@{$raw->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		foreach my $div (sort(keys(%$uqxx_divs))) {
			foreach my $pred (sort(keys(%$uqxx_preds))) {
				open(my $AVS, ">clip002-src-$srcn-$pred-div$div-$size.avs") || die $!;
				open(my $AVSSRC, "<clip002-src-$srcn.avs") || die "$srcn: $!";
				print $AVS <<__EOT__;
pred="$pred"
div=$div
width=$width
height=$height
__EOT__
				@_ = <$AVSSRC>;
				print $AVS @_;
				close($AVSSRC);
				close($AVS);
				print $FH <<__EOT__;
VirtualDub.Open("clip002-src-$srcn-$pred-div$div-$size.avs");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat($ofmt);
VirtualDub.video.SetCompression();
VirtualDub.video.filters.Clear();
VirtualDub.SaveAVI("clip002-raw-$dstn-$pred-div$div-$size.avi");
__EOT__
			}
		}
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
VirtualDub.Open("clip002-raw-$srcn-$progint-$pred-div$div-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip002-$fourcc-$progint-$pred-div$div-$size.avi");
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
	{ fourcc => "uqy0", srcn => "yuv10bit_yuv420p16le",  sizes => $uqxx_sizes_420 },
];

foreach my $comp (@$uqxx_comps) {
	my $fourcc = $comp->{fourcc};
	my $srcn = $comp->{srcn};
	foreach my $sizepair (@{$comp->{sizes}}) {
		my $width  = $sizepair->[0];
		my $height = $sizepair->[1];
		my $size = $width . "x" . $height;
		foreach my $div (sort(keys(%$uqxx_divs))) {
			my $confval = $uqxx_divs->{$div};
			my $confstr = pack("V", $confval);
			my $confb64 = encode_base64($confstr, "");
			print $FH <<__EOT__;
VirtualDub.Open("clip002-raw-$srcn-left-div$div-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip002-$fourcc-left-div$div-$size.avi");
__EOT__
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
VirtualDub.Open("clip002-raw-$srcn-progressive-gradient-div$div-$size.avi");
VirtualDub.video.SetMode(3);
VirtualDub.video.SetInputFormat(0);
VirtualDub.video.SetOutputFormat(0);
VirtualDub.video.SetCompression("$fourcc", 0, 0, 0);
VirtualDub.video.SetCompData(4, "$confb64");
VirtualDub.SaveAVI("clip002-$fourcc-div$div-$size.avi");
__EOT__
		}
	}
}
