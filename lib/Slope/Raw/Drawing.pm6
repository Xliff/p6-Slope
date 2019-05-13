use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::Drawing;

sub slope_cairo_circle (cairo_t $cr, SlopePoint $center, double $radius)
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

sub slope_cairo_line_cosmetic (cairo_t $cr, SlopePoint $p1, SlopePoint $p2, double $width)
  is native(slope)
  is export
  { * }

sub slope_cairo_rect (cairo_t $cr, SlopeRect $rec)
  is native(slope)
  is export
  { * }

sub slope_cairo_round_rect (cairo_t $cr, SlopeRect $rec, double $rad)
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

sub slope_cairo_text (cairo_t $cr, double $x, double $y, char $utf8)
  is native(slope)
  is export
  { * }

sub slope_color_parse (char $c)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_rect_contains (SlopeRect $rect, double $x, double $y)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_rect_translate (SlopeRect $rect, double $dx, double $dy)
  is native(slope)
  is export
  { * }

sub slope_similar (double $x1, double $x2)
  returns uint32
  is native(slope)
  is export
  { * }
