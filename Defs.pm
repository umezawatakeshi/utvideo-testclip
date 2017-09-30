#

package Defs;

use strict;
use warnings;

BEGIN {
	use Exporter();
	our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, $EXPORT_TAGS);
	$VERSION = 1.00;
	@ISA = qw(Exporter);
	push(@EXPORT, qw(VDVFMT_AUTO VDVFMT_RGB15 VDVFMT_RGB16 VDVFMT_RGB24 VDVFMT_RGB32 VDVFMT_Y8 VDVFMT_UYVY VDVFMT_YUY2 VDVFMT_YV24 VDVFMT_YV16 VDVFMT_YV12 VDVFMT_YVU9));
	push(@EXPORT, qw(VDVMODE_DIRECT VDVMODE_FAST VDVMODE_SLOW VDVMODE_FULL));
	push(@EXPORT, qw($sizes_444 $sizes_422 $sizes_420 $sizes_444_int $sizes_422_int $sizes_420_int));
}
our @EXPORT_OK;

# VirtualDub video formats (for video.SetInputFormat/SetOutputFormat)
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

# VirtualDub video modes (for video.GetMode/SetMode)
sub VDVMODE_DIRECT() { 0 }
sub VDVMODE_FAST()   { 1 }
sub VDVMODE_SLOW()   { 2 }
sub VDVMODE_FULL()   { 3 }

# clip sizes
our $sizes_444     = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $sizes_422     = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 255 ], [ 384, 254 ], [ 384, 253 ], [ 384, 512 ] ];
our $sizes_420     = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 254 ],               [ 384, 512 ] ];
our $sizes_444_int = [ [ 384, 256 ], [ 383, 256 ], [ 382, 256 ], [ 381, 256 ], [ 384, 254 ], [ 384, 512 ] ];
our $sizes_422_int = [ [ 384, 256 ],               [ 382, 256 ],               [ 384, 254 ], [ 384, 512 ] ];
our $sizes_420_int = [ [ 384, 256 ],               [ 382, 256 ],                             [ 384, 512 ] ];

1;
