use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::XYSeries;

sub slope_xyscale_get_axis (SlopeXyScale $self, int32 $axis_id)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_xyscale_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_xyscale_new ()
  returns SlopeScale
  is native(slope)
  is export
  { * }

sub slope_xyscale_new_axis (Str $x_title, Str $y_title, Str $top_title)
  returns SlopeScale
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_axis (SlopeXyScale $self, int32 $axis_flag)
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_interaction (SlopeXyScale $self, int32 $interaction)
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_x_range (SlopeXyScale $self, gdouble $min, gdouble $max)
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_y_range (SlopeXyScale $self, gdouble $min, gdouble $max)
  is native(slope)
  is export
  { * }
