use v6.c;

use nqp;

use Cairo;

use GTK::Compat::Types;
use GLib::Roles::Pointers;

unit package Slope::Raw::Types;

our subset CairoObject is export of Mu where Cairo::Context | cairo_t;

# Number of times a forced compile has been requested.
constant forced = 5;

constant slope is export = 'slope',v0;

constant SlopeColor is export := guint32;

class SlopeChart       is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeFigure      is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeItem        is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeLegend      is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeScale       is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeView        is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeXyAxis      is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeXyScale     is repr('CPointer') does GLib::Roles::Pointers is export { }
class SlopeXySeries    is repr('CPointer') does GLib::Roles::Pointers is export { }

class SlopePoint is repr('CStruct') does GLib::Roles::Pointers is export {
  has gdouble $.x is rw;
  has gdouble $.y is rw;
}

class SlopeRect  is repr('CStruct') does GLib::Roles::Pointers is export {
  has gdouble $.x      is rw;
  has gdouble $.y      is rw;
  has gdouble $.width  is rw;
  has gdouble $.height is rw;
}

class SlopeMouseEvent is repr('CStruct') does GLib::Roles::Pointers is export {
  has gdouble $.x      is rw;
  has gdouble $.y      is rw;
  has guint32 $.button is rw;
  has guint32 $.type   is rw;
}

class SlopeSample is repr('CStruct') does GLib::Roles::Pointers is export {
  has gdouble $.coord is rw;
  has Str     $!label;

  method label is rw {
    Proxy.new:
      FETCH => sub ($) { $!label },
      STORE => -> $, Str() $nv {
        nqp::bindattr(
          nqp::decont(self),
          SlopeSample,
          '$!label',
          nqp::unbox_s( $nv )
        )
      };
  }

  submethod BUILD(:$!coord, :$label) {
    self.label = $label;
  }

}

class SlopeSampler is repr('CStruct') does GLib::Roles::Pointers is export {
  has GList   $!sample_list;
  has guint32 $.mode is rw;
  has gdouble $.min  is rw;
  has gdouble $.max  is rw;
  has gdouble $.hint is rw;

  method sample_list is rw {
    Proxy.new:
      FETCH => sub ($) { $!sample_list },
      STORE => -> $, GList() $nv {
        nqp::bindattr(
          nqp::decont(self),
          SlopeSampler,
          '$!sample_list',
          nqp::decont( $nv )
        )
      };
  }
}

our enum SlopeXyAxisComponent is export (
  SLOPE_XYAXIS_LINE              => 0x00000001,
  SLOPE_XYAXIS_TICKS_UP          => 0x00000002,
  SLOPE_XYAXIS_TICKS_DOWN        => 0x00000004,
  SLOPE_XYAXIS_TITLE             => 0x00000008,
  SLOPE_XYAXIS_GRID              => 0x00000010,
  SLOPE_XYAXIS_DEFAULT_UP        => 0x00000001 +| 0x00000002 +| 0x00000008,
  SLOPE_XYAXIS_DEFAULT_DOWN      => 0x00000001 +| 0x00000004 +| 0x00000008,
  SLOPE_XYAXIS_DEFAULT_UP_GRID   => 0x00000001 +| 0x00000002 +| 0x00000008 +| 0x00000010,
  SLOPE_XYAXIS_DEFAULT_DOWN_GRID => 0x00000001 +| 0x00000004 +| 0x00000008 +| 0x00000010,
  SLOPE_XYAXIS_ALL_COMPONENT     => 0xFFFFFFFF,
);

our enum SlopeMouseButton is export <
  SLOPE_MOUSE_BUTTON_LEFT
  SLOPE_MOUSE_BUTTON_RIGHT
  SLOPE_MOUSE_BUTTON_NONE
>;

our enum SlopeOrientation is export <
  SLOPE_VERTICAL
  SLOPE_HORIZONTAL
>;

our enum SlopeXyScaleAxis is export (
  SLOPE_XYSCALE_AXIS_BOTTOM =>  0,
  SLOPE_XYSCALE_AXIS_TOP    =>  1,
  SLOPE_XYSCALE_AXIS_LEFT   =>  2,
  SLOPE_XYSCALE_AXIS_RIGHT  =>  3,
  SLOPE_XYSCALE_AXIS_X      =>  4,
  SLOPE_XYSCALE_AXIS_Y      =>  5
);

our enum SlopeMouseEventType is export <
  SLOPE_MOUSE_PRESS
  SLOPE_MOUSE_DOUBLE_PRESS
  SLOPE_MOUSE_MOVE
  SLOPE_MOUSE_MOVE_PRESSED
  SLOPE_MOUSE_RELEASE
>;

our enum SlopeLegendPosition is export <
  SLOPE_LEGEND_CUSTOM
  SLOPE_LEGEND_TOP
  SLOPE_LEGEND_BOTTOM
  SLOPE_LEGEND_LEFT
  SLOPE_LEGEND_RIGHT
  SLOPE_LEGEND_TOPLEFT
  SLOPE_LEGEND_TOPRIGHT
  SLOPE_LEGEND_BOTTOMLEFT
  SLOPE_LEGEND_BOTTOMRIGHT
>;

our enum SlopeXyScaleAxisFlag is export <
  SLOPE_XYSCALE_NO_AXIS
  SLOPE_XYSCALE_FRAME_AXIS
  SLOPE_XYSCALE_FRAME_AXIS_GRID
  SLOPE_XYSCALE_ZERO_AXIS
  SLOPE_XYSCALE_FRAME_LINE
>;

our enum SlopeFigureFrameMode is export <
  SLOPE_FIGURE_RECTANGLE
  SLOPE_FIGURE_ROUNDRECTANGLE
>;

our enum SlopeXyScaleInteracion is export (
  SLOPE_XYSCALE_INTERACTION_ZOOM      =>  0,
  SLOPE_XYSCALE_INTERACTION_TRANSLATE =>  1
);

our enum SlopeCorner is export <
  SLOPE_TOPLEFT
  SLOPE_TOPRIGHT
  SLOPE_BOTTOMLEFT
  SLOPE_BOTTOMRIGHT
>;

our enum SlopeSamplerMode is export <
  SLOPE_SAMPLER_MANUAL
  SLOPE_SAMPLER_AUTO_DECIMAL
>;

our enum SlopeColors is export (
  SLOPE_WHITE          => 0xFFFFFFFF,
  SLOPE_RED            => 0xFF0000FF,
  SLOPE_GREEN          => 0x00FF00FF,
  SLOPE_BLUE           => 0x0000FFFF,
  SLOPE_BLACK          => 0x000000FF,
  SLOPE_COLOR_NULL     => 0x00000000,
  SLOPE_YELLOW         => 0xFFFF00FF,
  SLOPE_CYAN           => 0x00FFFFFF,
  SLOPE_BLUEVIOLET     => 0x8A2BE2FF,
  SLOPE_BROWN          => 0xA52A2AFF,
  SLOPE_CADETBLUE      => 0x5F9EA0FF,
  SLOPE_CHOCOLATE      => 0xD2691EFF,
  SLOPE_DARKGOLDENROD  => 0xB8860BFF,
  SLOPE_DARKMAGENTA    => 0x8B008BFF,
  SLOPE_HOTPINK        => 0xFF69B4FF,
  SLOPE_LIGHTSKYBLUE   => 0x87CEFAFF,
  SLOPE_LIGHTSTEELBLUE => 0xB0C4DEFF,
  SLOPE_MIDNIGHTBLUE   => 0x191970FF,
  SLOPE_MAROON         => 0x800000FF,
  SLOPE_TEAL           => 0x008080FF,
  SLOPE_PALETURQUOISE  => 0xAFEEEEFF
);

sub SLOPE_GET_RED(\color)    { (color +> 24) +& 0xFF }
sub SLOPE_GET_GREEN(\color)  { (color +> 16) +& 0xFF }
sub SLOPE_GET_BLUE(\color)   { (color +>  8) +& 0xFF }
sub SLOPE_GET_ALPHA(\color)  {  color        +& 0xFF }
sub SLOPE_GET_REDF(\color)   { SLOPE_GET_RED(color).Num   / 255.0 }
sub SLOPE_GET_GREENF(\color) { SLOPE_GET_GREEN(color).Num / 255.0 }
sub SLOPE_GET_BLUEF(\color)  { SLOPE_GET_BLUE(color).Num  / 255.0 }
sub SLOPE_GET_ALPHAF(\color) { SLOPE_GET_ALPHA(color).Num / 255.0 }

sub SLOPE_SET_RED(\color, \red)     { color = (color +& 0x00FFFFFF) +| ((red   +& 0xFF) +< 24) }
sub SLOPE_SET_GREEN(\color, \green) { color = (color +& 0xFF00FFFF) +| ((green +& 0xFF) +< 16) }
sub SLOPE_SET_BLUE(\color, \blue)   { color = (color +& 0xFFFF00FF) +| ((blue  +& 0xFF) +< 8)  }
sub SLOPE_SET_ALPHA(\color, \alpha) { color = (color +& 0xFFFFFF00) +| (alpha  +& 0xFF)        }
sub SLOPE_COLOR(\r, \g, \b, \a)     { ((r +& 0xFF) +< 24) +| ((g +& 0xFF) +< 16) +| ((b +& 0xFF) +< 8) +| (a +& 0xFF) }
sub SLOPE_COLOR_IS_NULL(\color)     { SLOPE_GET_ALPHA(color) == 0 }
sub SLOPE_GRAY(\value)              { SLOPE_COLOR(value, value, value, 0xFF) }

sub SLOPE_COORD_TO_PIXEL(\coord) { (coord + 0.5).Int }