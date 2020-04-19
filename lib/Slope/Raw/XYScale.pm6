use v6.c;

use NativeCall;

use Slope::Raw::Types;

unit package Slope::Raw::XYScale;

sub slope_xyscale_get_axis (SlopeXyScale $self, gint $axis_id)
  returns SlopeXyAxis
  is native(slope)
  is export
  { * }

sub slope_xyscale_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_xyscale_new ()
  returns SlopeXyScale
  is native(slope)
  is export
  { * }

sub slope_xyscale_new_axis (Str $x_title, Str $y_title, Str $top_title)
  returns SlopeXyScale
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_axis (SlopeXyScale $self, gint $axis_flag)
  is native(slope)
  is export
  { * }

sub slope_xyscale_set_interaction (SlopeXyScale $self, gint $interaction)
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
