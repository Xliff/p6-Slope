use v6.c;

use Cairo;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package Slope::Raw::Definitions;

our subset CairoObject is export of Mu where Cairo::Context | Cairo::cairo_t;

# Number of times a forced compile has been requested.
my constant forced = 32;

constant slope is export = 'slope',v0;

constant SlopeColor is export := guint32;

class SlopeChart       is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeFigure      is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeItem        is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeLegend      is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeScale       is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeView        is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeXyAxis      is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeXyScale     is repr<CPointer> does GLib::Roles::Pointers is export { }
class SlopeXySeries    is repr<CPointer> does GLib::Roles::Pointers is export { }

class SlopePoint is repr<CStruct> does GLib::Roles::Pointers is export {
  has gdouble $.x is rw;
  has gdouble $.y is rw;
}

class SlopeRect  is repr<CStruct> does GLib::Roles::Pointers is export {
  has gdouble $.x      is rw;
  has gdouble $.y      is rw;
  has gdouble $.width  is rw;
  has gdouble $.height is rw;
}

class SlopeMouseEvent is repr<CStruct> does GLib::Roles::Pointers is export {
  has gdouble $.x      is rw;
  has gdouble $.y      is rw;
  has guint32 $.button is rw;
  has guint32 $.type   is rw;
}

class SlopeSample is repr<CStruct> does GLib::Roles::Pointers is export {
  has gdouble $.coord is rw;
  has Str     $!label;

  method label is rw {
    Proxy.new:
      FETCH => -> $ { $!label },
      STORE => -> $, Str() $nv { self.^attributes[1].set_value(self, $nv) };
  }

  submethod BUILD(:$!coord, :$label) {
    self.label = $label;
  }

}

class SlopeSampler is repr<CStruct> does GLib::Roles::Pointers is export {
  has GList   $!sample_list;
  has guint32 $.mode is rw;
  has gdouble $.min  is rw;
  has gdouble $.max  is rw;
  has gdouble $.hint is rw;

  method sample_list is rw {
    Proxy.new:
      FETCH => -> $ { $!sample_list },
      STORE => -> $, GList() $nv { self.^attributes[0].set_value(self, $nv) };
  }
}