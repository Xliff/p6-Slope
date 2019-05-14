use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::XYAxis;

use Slope::Item;
use Slope::Sampler;

our subset XYAxisAncestry is export of Mu
  where SlopeXyAxis | SlopeItemAncestry;

class Slope::XYAxis is Slope::Item {
  has SlopeXyAxis $!xya;

  submethod BLESS (:$axis) {
    self.setItem( cast(SlopeItem, $!xya = $axis) );
  }

  multi method new (XYAxisAncestry $axis) {
    self.bless(:$axis);
  }
  multi method new (Str() $title) {
    slope_xyaxis_new($!xya, $title);
  }

  method grid_color is rw is also<grid-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_grid_color($!xya);
      },
      STORE => sub ($, $color is copy) {
        slope_xyaxis_set_grid_color($!xya, $color);
      }
    );
  }

  method line_color is rw is also<line-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_line_color($!xya);
      },
      STORE => sub ($, $color is copy) {
        slope_xyaxis_set_line_color($!xya, $color);
      }
    );
  }

  method selected is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_selected($!xya);
      },
      STORE => sub ($, $selected is copy) {
        slope_xyaxis_set_selected($!xya, $selected);
      }
    );
  }

  method selection_color is rw is also<selection-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_xyaxis_get_selection_color($!xya);
      },
      STORE => sub ($, $color is copy) {
        slope_xyaxis_set_selection_color($!xya, $color);
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
      STORE => sub ($, $color is copy) {
        slope_xyaxis_set_title_color($!xya, $color);
      }
    );
  }

  method get_sampler is also<get-sampler> {
    Slope::Sampler.new( slope_xyaxis_get_sampler($!xya) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_xyaxis_get_type, $n, $t );
  }

  method set_components (Int() $components) is also<set-components> {
    my guint $c = resolve-uint($components);
    slope_xyaxis_set_components($!xya, $c);
  }

  method set_position (Num() $min, Num() $max, Num() $anchor)
    is also<set-position>
  {
    my gdouble ($mn, $mx, $a) = ($min, $max, $anchor);
    slope_xyaxis_set_position($!xya, $min, $max, $anchor);
  }

}
