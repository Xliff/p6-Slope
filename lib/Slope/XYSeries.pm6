use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Item;

our XYSeriesAncestry is export of Mu
  where SlopeXySeries | ItemAncestry;

class Slope::XYSeries is Slope::Item {
  has SlopeXySeries $!xys;

  submethod BUILD (:$series) {
    my $to-parent;
    $!xys = do given $legend {
      when SlopeXySeries {
        $to-parent = cast(SlopeItem, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(SlopeLegend, $_);
      }
    }
    self.setItem($to-parent);
  }

  method Slope::Raw::Types::SlopeXySeries
    is also<
      SlopeXySeries
      XySeries
    >
  { $!xys }

  multi method new (XYSeriesAncestry $series) {
    self.bless(:$series);
  }
  multi method new {
    self.bless( series => slope_xyscale_new() );
  }

  method get_axis (Int() $axis_id) is also<get-axis> {
    my gint $ai = resolve-int($axis_id);
    slope_xyscale_get_axis($!xys, $ai);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_xyscale_get_type, $n, $t );
  }

  method new_axis (Str() $y_title, Str() $top_title) is also<new-axis> {
    slope_xyscale_new_axis($!xys, $y_title, $top_title);
  }

  method set_axis (Int() $axis_flag) is also<set-axis> {
    my gint $af = resolve-int($axis_flag);
    slope_xyscale_set_axis($!xys, $af);
  }

  method set_interaction (Int() $interaction) is also<set-interaction> {
    my gint $i = resolve-int($interaction);
    slope_xyscale_set_interaction($!xys, $i);
  }

  method set_x_range (Num() $min, Num() $max) is also<set-x-range> {
    my gdouble ($mn, $mx) = ($min, $max);
    slope_xyscale_set_x_range($!xys, $mn, $mx);
  }

  method set_y_range (Num() $min, Num() $max) is also<set-y-range> {
    my gdouble ($mn, $mx) = ($min, $max);
    slope_xyscale_set_y_range($!xys, $mn, $mx);
  }

}
