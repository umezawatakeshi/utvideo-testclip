#

package Defs;

use strict;
use warnings;

BEGIN {
	use Exporter();
	our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, $EXPORT_TAGS);
	$VERSION = 1.00;
	@ISA = qw(Exporter);
	push(@EXPORT, qw(VDVFMT_AUTO VDVFMT_RGB15 VDVFMT_RGB16 VDVFMT_RGB24 VDVFMT_RGB32 VDVFMT_Y8 VDVFMT_UYVY VDVFMT_YUY2 VDVFMT_YV24 VDVFMT_YV16 VDVFMT_YV12 VDVFMT_YVU9 VDVFMT_NV12));
	push(@EXPORT, qw(VDVFMT_v210 VDVFMT_b64a VDVFMT_r210 VDVFMT_P210 VDVFMT_P216));
	push(@EXPORT, qw(VDVMODE_DIRECT VDVMODE_FAST VDVMODE_SLOW VDVMODE_FULL));
	push(@EXPORT, qw($sizes_444 $sizes_422 $sizes_420 $sizes_444_int $sizes_422_int $sizes_420_int));

	push(@EXPORT, qw($ulxx_sizes_444 $ulxx_sizes_422 $ulxx_sizes_420 $ulxx_sizes_444_int $ulxx_sizes_422_int $ulxx_sizes_420_int));
	push(@EXPORT, qw($ulxx_divs $ulxx_preds $ulxx_progints));

	push(@EXPORT, qw($uqxx_sizes_444 $uqxx_sizes_422 $uqxx_sizes_420));
	push(@EXPORT, qw($uqxx_divs $uqxx_preds));

	push(@EXPORT, qw($umxx_sizes_444 $umxx_sizes_422 ));
	push(@EXPORT, qw($umxx_divs));
}
our @EXPORT_OK;

# VirtualDub video formats (for video.SetInputFormat/SetOutputFormat) (from src/h/vd2/Kasumi/pixmap.h)
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
sub VDVFMT_v210()  { 21 }
sub VDVFMT_NV12()  { 23 }
sub VDVFMT_b64a()  { 57 }
sub VDVFMT_r210()  { 65 }
sub VDVFMT_P210()  { 68 }
sub VDVFMT_P216()  { 70 }

# VirtualDub video modes (for video.GetMode/SetMode)
sub VDVMODE_DIRECT() { 0 }
sub VDVMODE_FAST()   { 1 }
sub VDVMODE_SLOW()   { 2 }
sub VDVMODE_FULL()   { 3 }

# clip sizes
our $sizes_444     = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 352, 256 ], [ 322, 256 ], [ 320, 256 ], [ 318, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $sizes_422     = [ [ 384, 256 ],               [ 382, 256 ],               [ 352, 256 ], [ 322, 256 ], [ 320, 256 ], [ 318, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $sizes_420     = [ [ 384, 256 ],               [ 382, 256 ],                                                                                     [ 384, 254 ],               [ 384, 512 ] ];
our $sizes_444_int = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ],                                                                       [ 384, 254 ],               [ 384, 512 ] ];
our $sizes_422_int = [ [ 384, 256 ],               [ 382, 256 ],                                                                                     [ 384, 254 ],               [ 384, 512 ] ];
our $sizes_420_int = [ [ 384, 256 ],               [ 382, 256 ],                                                                                                                 [ 384, 512 ] ];


# ULxx

our $ulxx_sizes_444     = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $ulxx_sizes_422     = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $ulxx_sizes_420     = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 254 ],               [ 384, 512 ] ];
our $ulxx_sizes_444_int = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ],               [ 384, 254 ],               [ 384, 512 ] ];
our $ulxx_sizes_422_int = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 254 ],               [ 384, 512 ] ];
our $ulxx_sizes_420_int = [ [ 384, 256 ],               [ 382, 256 ],                                                         [ 384, 512 ] ];

our $ulxx_divs = {
	1  => 0x00000000,
	8  => 0x00000007,
	11 => 0x0000000a,
};

our $ulxx_preds = {
	left     => 0x00000100,
	gradient => 0x00000200,
	median   => 0x00000300,
};

our $ulxx_progints = {
	progressive => 0x00000000,
	interlace   => 0x00000800,
};


# UQxx

our $uqxx_sizes_444     = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $uqxx_sizes_422     = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $uqxx_sizes_420     = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 254 ],               [ 384, 512 ] ];

our $uqxx_divs = {
	1  => 0x00000000,
	8  => 0x00070000,
	11 => 0x000a0000,
};

our $uqxx_preds = {
	left     => 0x00000000,
};


# UMxx

our $umxx_sizes_444     = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 352, 256 ], [ 322, 256 ], [ 320, 256 ], [ 318, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $umxx_sizes_422     = [ [ 384, 256 ],               [ 382, 256 ],               [ 352, 256 ], [ 322, 256 ], [ 320, 256 ], [ 318, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];

our $umxx_divs = {
	1  => 0x00000000,
	8  => 0x00000700,
	11 => 0x00000a00,
};

1;
