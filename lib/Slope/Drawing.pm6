use v6.c;

use Cairo;

use GTK::Compat::Types;
use Slope::Raw::Types;

use Slope::Raw::Drawing;

my subset CairoObject of Mu where Cairo::Context | cairo_t;

class Slope::Drawing {
  has cairo_t $!d;
  
  submethod BUILD (:$cairo) {
    $!d = $cairo;
  }
  
  method new (CairoObject $c is copy {
    $c .= Context if $c ~~ Cairo::Context;
    self.bless( cairo => $c );
  }
  
  method circle (SlopePoint $center, double $radius) {
    slope_cairo_circle($!d, $center, $radius);
  }

  method draw (SlopeColor $stroke, SlopeColor $fill) {
    slope_cairo_draw($!d, $stroke, $fill);
  }

  method line (SlopePoint $p1, SlopePoint $p2) {
    slope_cairo_line($!d, $p1, $p2);
  }

  method line_cosmetic (SlopePoint $p1, SlopePoint $p2, double $width) {
    slope_cairo_line_cosmetic($!d, $p1, $p2, $width);
  }

  method rect (SlopeRect $rec) {
    slope_cairo_rect($!d, $rec);
  }

  method round_rect (SlopeRect $rec, double $rad) {
    slope_cairo_round_rect($!d, $rec, $rad);
  }

  method set_antialias (gboolean $antialias) {
    slope_cairo_set_antialias($!d, $antialias);
  }

  method set_color (SlopeColor $color) {
    slope_cairo_set_color($!d, $color);
  }

  method text (double $x, double $y, char $utf8) {
    slope_cairo_text($!d, $x, $y, $utf8);
  }

  method color_parse (Str() $color) {
    slope_color_parse($color);
  }

  method slope_rect_contains (SlopeRect $rect, double $x, double $y) {
    slope_rect_contains($rect, $x, $y);
  }

  method slope_rect_translate (SlopeRect $rect, double $dx, double $dy) {
    slope_rect_translate($rect, $dx, $dy);
  }

  method slope_similar (double $x1, double $x2) {
    slope_similar($x1, $x2);
  }

}
