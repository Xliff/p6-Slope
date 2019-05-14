use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::XYSeries;

sub slope_xyseries_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_xyseries_new ()
  returns SlopeXySeries
  is native(slope)
  is export
  { * }

sub slope_xyseries_new_filled (
  Str $name,
  CArray[gdouble] $x_vec,
  CArray[gdouble] $y_vec,
  glong $n_pts,
  Str $style
)
  returns SlopeXySeries
  is native(slope)
  is export
  { * }

sub slope_xyseries_set_data (
  SlopeXySeries $self,
  CArray[gdouble] $x_vec,
  CArray[gdouble] $y_vec,
  glong $n_pts
)
  is native(slope)
  is export
  { * }

sub slope_xyseries_set_style (SlopeXySeries $self, Str $style)
  is native(slope)
  is export
  { * }

sub slope_xyseries_update (SlopeXySeries $self)
  is native(slope)
  is export
  { * }

sub slope_xyseries_update_data (
  SlopeXySeries $self,
  CArray[gdouble] $x_vec,
  CArray[gdouble] $y_vec,
  glong $n_pts
)
  is native(slope)
  is export
  { * }
