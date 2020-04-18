use v6.c;

use NativeCall;


use Slope::Raw::Types;

unit package Slope::Raw::Drawing;

sub slope_cairo_circle (cairo_t $cr, SlopePoint $center, gdouble $radius)
  is native(slope)
  is export
  { * }

sub slope_cairo_draw (cairo_t $cr, SlopeColor $stroke, SlopeColor $fill)
  is native(slope)
  is export
  { * }

sub slope_cairo_line (cairo_t $cr, SlopePoint $p1, SlopePoint $p2)
  is native(slope)
  is export
  { * }

sub slope_cairo_line_cosmetic (cairo_t $cr, SlopePoint $p1, SlopePoint $p2, gdouble $width)
  is native(slope)
  is export
  { * }

sub slope_cairo_rect (cairo_t $cr, SlopeRect $rec)
  is native(slope)
  is export
  { * }

sub slope_cairo_round_rect (cairo_t $cr, SlopeRect $rec, gdouble $rad)
  is native(slope)
  is export
  { * }

sub slope_cairo_set_antialias (cairo_t $cr, gboolean $antialias)
  is native(slope)
  is export
  { * }

sub slope_cairo_set_color (cairo_t $cr, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_cairo_text (cairo_t $cr, gdouble $x, gdouble $y, Str $utf8)
  is native(slope)
  is export
  { * }

sub slope_color_parse (Str $c)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_rect_contains (SlopeRect $rect, gdouble $x, gdouble $y)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_rect_translate (SlopeRect $rect, gdouble $dx, gdouble $dy)
  is native(slope)
  is export
  { * }

sub slope_similar (gdouble $x1, gdouble $x2)
  returns uint32
  is native(slope)
  is export
  { * }
