use v6.c;

use Method::Also;

use Slope::Raw::Types;
use Slope::Raw::XYScale;

use Slope::Scale;
use Slope::XYAxis;

our subset SlopeXYScaleAncestry is export of Mu
  where SlopeXyScale | SlopeScaleAncestry;

class Slope::XYScale is Slope::Scale {
  has SlopeXyScale $!xys;

  submethod BUILD (:$xyscale) {
    self.setSlopeXYScale($xyscale);
  }

  method setSlopeXYScale (SlopeXYScaleAncestry $_) {
    my $to-parent;

    $!xys = do {
      when SlopeXyScale {
        $to-parent = cast(SlopeScale, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SlopeXyScale, $_);
      }
    }
    self.setSlopeScale($to-parent);
  }

  method Slope::Raw::Definitions::SlopeXyScale
    is also<SlopeXyScale>
  { $!xys }

  multi method new (SlopeXyScale $xyscale) {
    $xyscale ?? self.bless(:$xyscale) !! Nil;
  }
  multi method new {
    my $xyscale = slope_xyscale_new();

    $xyscale ?? self.bless(:$xyscale) !! Nil;
  }

  method new_axis (Str() $x_title, Str() $y_title, Str() $top_title)
    is also<new-axis>
  {
    my $xyscale = slope_xyscale_new_axis($x_title, $y_title, $top_title);

    $xyscale ?? self.bless(:$xyscale) !! Nil;
  }

  method get_axis (Int() $axis_id, :$raw = False) is also<get-axis> {
    my guint $aid = $axis_id;
    my $a = slope_xyscale_get_axis($!xys, $aid);

    $a ??
      ( $raw ?? $a !! Slope::XYAxis.new( $a ) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_xyscale_get_type, $n, $t );
  }

  method set_axis (Int() $axis_flag) is also<set-axis> {
    my gint $af = $axis_flag;

    slope_xyscale_set_axis($!xys, $af);
  }

  method set_interaction (Int() $interaction) is also<set-interaction> {
    my gint $i = $interaction;

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
