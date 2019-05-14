use v6.c;

use Cairo;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::Drawing;

class Slope::Drawing {
  has cairo_t $!d;

  submethod BUILD (:$cairo) {
    $!d = $cairo;
  }

  method Cairo::Context
    is also<
      Cairo::cairo_t
      Context
    >
  { $!d }

  method new (CairoObject $c is copy {
    $c .= Context if $c ~~ Cairo::Context;
    self.bless( cairo => $c );
  }

  method circle (SlopePoint $center, Num() $radius) {
    my gdouble $r = $radius;
    slope_cairo_circle($!d, $center, $r);
  }

  method draw (SlopeColor $stroke, SlopeColor $fill) {
    slope_cairo_draw($!d, $stroke, $fill);
  }

  method line (SlopePoint $p1, SlopePoint $p2) {
    slope_cairo_line($!d, $p1, $p2);
  }

  method line_cosmetic (SlopePoint $p1, SlopePoint $p2, Num() $width)
    is also<line-cosmetic>
  {
    my gdouble $w = $width;
    slope_cairo_line_cosmetic($!d, $p1, $p2, $w);
  }

  method rect (SlopeRect $rec) {
    slope_cairo_rect($!d, $rec);
  }

  method round_rect (SlopeRect $rec, Num() $rad) is also<round-rect> {
    my gdouble $r = $rad;
    slope_cairo_round_rect($!d, $rec, $r);
  }

  method set_antialias (Int() $antialias) is also<set-antialias> {
    my gboolean $aa = resolve-bool($antialias);
    slope_cairo_set_antialias($!d, $aa);
  }

  method set_color (SlopeColor $color) is also<set-color> {
    slope_cairo_set_color($!d, $color);
  }

  method text (Num() $x, Num() $y, Str() $utf8) {
    my gdouble ($xx, $yy) = ($x, $y);
    slope_cairo_text($!d, $xx, $yy, $utf8);
  }

  method color_parse (Str() $color) is also<color-parse> {
    slope_color_parse($color);
  }

  method slope_rect_contains (SlopeRect $rect, Num() $x, Num() $y)
    is also<slope-rect-contains>
  {
    my gdouble ($xx, $yy) = ($x, $y);
    slope_rect_contains($rect, $xx, $yy);
  }

  method slope_rect_translate (SlopeRect $rect, Num() $dx, Num() $dy)
    is also<slope-rect-translate>
  {
    my gdouble ($dxx, $dyy) = ($dx, $dy);
    slope_rect_translate($rect, $dxx, $dyy);
  }

  method slope_similar (Num() $x1, Num() $x2) is also<slope-similar> {
    my gdouble ($xx1, $xx2) = ($x1, $x2);
    slope_similar($xx1, $xx2);
  }

}
