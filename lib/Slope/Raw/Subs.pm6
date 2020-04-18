use v6.c;

use GLib::Raw::Definitions;

unit package Slope::Raw::Subs;

sub SLOPE_GET_RED        (\color) is export { (color +> 24) +& 0xFF }
sub SLOPE_GET_GREEN      (\color) is export { (color +> 16) +& 0xFF }
sub SLOPE_GET_BLUE       (\color) is export { (color +>  8) +& 0xFF }
sub SLOPE_GET_ALPHA      (\color) is export {  color        +& 0xFF }
sub SLOPE_GET_REDF       (\color) is export {   SLOPE_GET_RED(color).Num / 255.0 }
sub SLOPE_GET_GREENF     (\color) is export { SLOPE_GET_GREEN(color).Num / 255.0 }
sub SLOPE_GET_BLUEF      (\color) is export {  SLOPE_GET_BLUE(color).Num / 255.0 }
sub SLOPE_GET_ALPHAF     (\color) is export { SLOPE_GET_ALPHA(color).Num / 255.0 }

sub SLOPE_SET_RED        (\color, \red)    is export
  { color = (color +& 0x00FFFFFF) +| ((red   +& 0xFF) +< 24) }

sub SLOPE_SET_GREEN      (\color, \green)  is export
  { color = (color +& 0xFF00FFFF) +| ((green +& 0xFF) +< 16) }

sub SLOPE_SET_BLUE       (\color, \blue)   is export
  { color = (color +& 0xFFFF00FF) +| ((blue  +& 0xFF) +< 8)  }

sub SLOPE_SET_ALPHA      (\color, \alpha)  is export
  { color = (color +& 0xFFFFFF00) +| (alpha  +& 0xFF)        }

sub SLOPE_COLOR          (\r, \g, \b, \a)  is export
  { ((r +& 0xFF) +< 24) +| ((g +& 0xFF) +< 16) +| ((b +& 0xFF) +< 8) +| (a +& 0xFF) }

sub SLOPE_COLOR_IS_NULL  (\color)          is export
  { SLOPE_GET_ALPHA(color) == 0 }

sub SLOPE_GRAY           (\value)          is export
  { SLOPE_COLOR(value, value, value, 0xFF) }

sub SLOPE_COORD_TO_PIXEL (\coord)          is export
  { (coord + 0.5).Int }
