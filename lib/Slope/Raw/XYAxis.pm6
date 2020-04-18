use v6.c;

use NativeCall;


use Slope::Raw::Types;

unit package Slope::Raw::XYAxis;

sub slope_xyaxis_get_sampler (SlopeXyAxis $self)
  returns SlopeSampler
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_xyaxis_new (gint $orientation, Str $title)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_components (SlopeXyAxis $self, guint32 $components)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_position (
  SlopeXyAxis $self,
  gdouble $min,
  gdouble $max,
  gdouble $anchor
)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_grid_color (SlopeXyAxis $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_line_color (SlopeXyAxis $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_selected (SlopeXyAxis $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_selection_color (SlopeXyAxis $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_title (SlopeXyAxis $self)
  returns Str
  is native(slope)
  is export
  { * }

sub slope_xyaxis_get_title_color (SlopeXyAxis $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_grid_color (SlopeXyAxis $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_line_color (SlopeXyAxis $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_selected (SlopeXyAxis $self, gboolean $selected)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_selection_color (SlopeXyAxis $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_title (SlopeXyAxis $self, Str $title)
  is native(slope)
  is export
  { * }

sub slope_xyaxis_set_title_color (SlopeXyAxis $self, SlopeColor $color)
  is native(slope)
  is export
  { * }
