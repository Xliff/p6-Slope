use v6.c;

use Method::Also;
use NativeCall;

use Slope::Raw::Types;
use Slope::Raw::XYSeries;

use Slope::Item;

our subset SlopeXYSeriesAncestry is export of Mu
  where SlopeXySeries | SlopeItemAncestry;

class Slope::XYSeries is Slope::Item {
  has SlopeXySeries $!xys;

  submethod BUILD (:$series) {
    self.setSlopeXYSeries($series);
  }

  method setSlopeXYSeries (SlopeXYSeriesAncestry $_) {
    my $to-parent;

    $!xys = do {
      when SlopeXySeries {
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

  method Slope::Raw::Types::SlopeXySeries
    is also<
      SlopeXySeries
      XySeries
    >
  { $!xys }

  multi method new (SlopeXYSeriesAncestry $series) {
    $series ?? self.bless(:$series) !! Nil;
  }
  multi method new {
    my $series = slope_xyseries_new();

    $series ?? self.bless(:$series) !! Nil;
  }

  method !xy_to_vec ( @xy where so *.all.elems == 2 ) {
    my ($x_vec, $y_vec) = CArray[gdouble].new xx 2;
    my glong $np = @xy.elems;

    ($x_vec[$_], $y_vec[$_]) = |@xy[$_] for @xy;
    ($x_vec, $y_vec, $np);
  }
  method !x_and_y_to_vec (@x, @y) {
    my ($x_vec, $y_vec) = CArray[gdouble].new xx 2;
    my glong $np = (@x.elems, @y.elems).min;

    ($x_vec[$_], $y_vec[$_]) = (@x[$_], @y[$_]) for ^$np;
    ($x_vec, $y_vec, $np);
  }

  proto method new_filled (|)
    is also<new-filled>
  { * }

  multi method new_filled (
    Str() $name,
    @xy,
    Str() $style
  ) {
    samewith($name, |self!xy_to_vec(@xy), $style);
  }
  multi method new_filled (Str() $name, @x, @y, Str() $style) {
    samewith($name, |self!x_and_y_to_vec(@x, @y), $style);
  }
  multi method new_filled (
    Slope::XYSeries:U:
    Str() $name,
    CArray[gdouble] $x_vec,
    CArray[gdouble] $y_vec,
    Int() $n_pts,
    Str() $style
  ) {
    my glong $np = $n_pts;
    my $series = slope_xyseries_new_filled($name, $x_vec, $y_vec, $np, $style);

    $series ?? self.bless(:$series) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_xyseries_get_type, $n, $t);
  }

  proto method set_data (|)
    is also<set-data>
  { * }

  multi method set_data(@xy)  {
    samewith( |self!xy_to_vec(@xy) )
  }
  multi method set_data(@x, @y) {
    samewith( |self!x_and_y_to_vec(@x, @y) )
  }
  multi method set_data (
    CArray[gdouble] $x_vec,
    CArray[gdouble] $y_vec,
    Int() $n_pts
  ) {
    my glong $np = $n_pts;

    slope_xyseries_set_data($!xys, $x_vec, $y_vec, $np);
  }

  method set_style (Str() $style) is also<set-style> {
    slope_xyseries_set_style($!xys, $style);
  }

  method update {
    slope_xyseries_update($!xys);
  }

  proto method update_data
    is also<update-data>
  { * }

  multi method update_data(@xy) {
    samewith( self!xy_to_vec(@xy) );
  }
  multi method update_data(@x, @y) {
    samewith( self!x_and_y_to_vec(@x, @y) );
  }
  multi method update_data (
    CArray[gdouble] $x_vec,
    CArray[gdouble] $y_vec,
    Int() $n_pts
  ) {
    my glong $np = $n_pts;

    slope_xyseries_update_data($!xys, $x_vec, $y_vec, $np);
  }

}
