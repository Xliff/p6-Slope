use v6.c;

use Method::Also;

use Slope::Raw::Types;
use Slope::Raw::Legend;

use Slope::Item;

our subset SlopeLegendAncestry is export of Mu
  where SlopeLegend | SlopeItemAncestry;

class Slope::Legend is Slope::Item {
  has SlopeLegend $!l;

  submethod BUILD (:$legend) {
    my $to-parent;

    $!l = do given $legend {
      when SlopeLegend {
        $to-parent = cast(SlopeItem, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SlopeLegend, $_);
      }
    }
    self.setSlopeItem($to-parent);
  }

  method Slope::Raw::Types::SlopeLegend
    is also<
      SlopeLegend
      Legend
    >
  { $!l }

  multi method new (SlopeLegendAncestry $legend) {
    $legend ?? self.bless( :$legend ) !! Nil;
  }
  multi method new (Int() $orientation) {
    my guint $o = $orientation;
    my $legend = slope_legend_new($o);

    $legend ?? self.bless( :$legend ) !! Nil;
  }

  method anchor is rw {
    Proxy.new(
      FETCH => sub ($) {
        SlopeCornerEnum( slope_legend_get_anchor($!l) );
      },
      STORE => sub ($, Int() $anchor is copy) {
        my guint $a = $anchor;

        slope_legend_set_anchor($!l, $a);
      }
    );
  }

  method fill_color is rw is also<fill-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_legend_get_fill_color($!l);
      },
      STORE => sub ($, $color is copy) {
        slope_legend_set_fill_color($!l, $color);
      }
    );
  }

  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        SlopeOrientationEnum( slope_legend_get_orientation($!l) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

        slope_legend_set_orientation($!l, $o);
      }
    );
  }

  method stroke_color is rw is also<stroke-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_legend_get_stroke_color($!l);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_legend_set_stroke_color($!l, $c);
      }
    );
  }

  method stroke_width is rw is also<stroke-width> {
    Proxy.new(
      FETCH => sub ($) {
        slope_legend_get_stroke_width($!l);
      },
      STORE => sub ($, $width is copy) {
        slope_legend_set_stroke_width($!l, $width);
      }
    );
  }

  method add_item (SlopeItem() $item) is also<add-item> {
    slope_legend_add_item($!l, $item);
  }

  method clear_items is also<clear-items> {
    slope_legend_clear_items($!l);
  }

  method get_position (Num() $x, Num() $y) is also<get-position> {
    my gdouble ($xx, $yy) = ($x, $y);

    slope_legend_get_position($!l, $xx, $yy);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_legend_get_type, $n, $t );
  }

  method set_default_position (Int() $position)
    is also<set-default-position>
  {
    my guint $p = $position;

    slope_legend_set_default_position($!l, $p);
  }

  method set_position (Num() $x, Num() $y) is also<set-position> {
    my gdouble ($xx, $yy) = ($x, $y);

    slope_legend_set_position($!l, $xx, $yy);
  }

}
