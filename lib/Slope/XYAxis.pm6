use v6.c;

use Method::Also;

use Slope::Raw::Types;
use Slope::Raw::XYAxis;

use Slope::Item;
use Slope::Sampler;

our subset SlopeXYAxisAncestry is export of Mu
  where SlopeXyAxis | SlopeItemAncestry;

class Slope::XYAxis is Slope::Item {
  has SlopeXyAxis $!xya;

  submethod BUILD (:$axis) {
    self.setXYAxis($axis);
  }

  method setXYAxis (SlopeXYAxisAncestry $_) {
    my $to-parent;

    $!xya = do {
      when SlopeXyAxis {
        $to-parent = cast(SlopeItem, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SlopeXyAxis, $_);
      }
    }

    self.setSlopeItem($to-parent);
  }

  multi method new (SlopeXYAxisAncestry $axis) {
    $axis ?? self.bless(:$axis) !! Nil;
  }
  multi method new (Int() $orientation, Str() $title) {
    my SlopeOrientation $o = $orientation;
    my $axis = slope_xyaxis_new($o, $title);

    $axis ?? self.bless(:$axis) !! Nil;
  }

  method grid_color is rw is also<grid-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_grid_color($!xya);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_xyaxis_set_grid_color($!xya, $c);
      }
    );
  }

  method line_color is rw is also<line-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_line_color($!xya);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_xyaxis_set_line_color($!xya, $c);
      }
    );
  }

  method selected is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_selected($!xya);
      },
      STORE => sub ($, Int() $selected is copy) {
        my gboolean $s = $selected.so.Int;

        slope_xyaxis_set_selected($!xya, $s);
      }
    );
  }

  method selection_color is rw is also<selection-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_selection_color($!xya);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_xyaxis_set_selection_color($!xya, $c);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_title($!xya);
      },
      STORE => sub ($, Str() $title is copy) {
        slope_xyaxis_set_title($!xya, $title);
      }
    );
  }

  method title_color is rw is also<title-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_title_color($!xya);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_xyaxis_set_title_color($!xya, $c);
      }
    );
  }

  method get_sampler (:$raw = False) is also<get-sampler> {
    my $s = slope_xyaxis_get_sampler($!xya);

    $s ??
      ( $raw ?? $s !! Slope::Sampler.new( $s ) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_xyaxis_get_type, $n, $t );
  }

  method set_components (Int() $components) is also<set-components> {
    my guint $c = $components;

    slope_xyaxis_set_components($!xya, $c);
  }

  method set_position (Num() $min, Num() $max, Num() $anchor)
    is also<set-position>
  {
    my gdouble ($mn, $mx, $a) = ($min, $max, $anchor);

    slope_xyaxis_set_position($!xya, $min, $max, $anchor);
  }

}
