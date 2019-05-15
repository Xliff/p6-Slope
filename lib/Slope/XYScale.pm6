use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::XYScale;

use Slope::Scale;
use Slope::XYAxis;

our subset XYScaleAncestry is export of Mu
  where SlopeXyScale | SlopeScaleAncestry;

class Slope::XYScale is Slope::Scale {
  has SlopeXyScale $!xys;

  submethod BUILD (:$xyscale) {
    self.setScale( cast(SlopeScale, $!xys = $xyscale) );
  }

  method Slope::Raw::Types::SlopeXyScale
    is also<SlopeXyScale>
  { $!xys }

  multi method new (SlopeXyScale $xyscale) {
    self.bless(:$xyscale);
  }
  multi method new {
    self.bless( xyscale => slope_xyscale_new() );
  }

  method new_axis (Str() $x_title, Str() $y_title, Str() $top_title)
    is also<new-axis>
  {
    self.bless(
      xyscale => slope_xyscale_new_axis(
        $x_title, $y_title, $top_title
      )
    );
  }

  method get_axis (Int() $axis_id) is also<get-axis> {
    my guint $aid = resolve-uint($axis_id);
    my $a = slope_xyscale_get_axis($!xys, $aid);
    Slope::XYAxis.new( $a );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_xyscale_get_type, $n, $t );
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
