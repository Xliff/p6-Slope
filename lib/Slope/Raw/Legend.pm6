use v6.c;

use NativeCall;

use Slope::Raw::Types;

unit package Slope::Raw::Legend;

sub slope_legend_add_item (SlopeLegend $self, SlopeItem $item)
  is native(slope)
  is export
  { * }

sub slope_legend_clear_items (SlopeLegend $self)
  is native(slope)
  is export
  { * }

sub slope_legend_get_position (SlopeLegend $self, gdouble $x, gdouble $y)
  is native(slope)
  is export
  { * }

sub slope_legend_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_legend_new (
  uint32 $orientation # SlopeOrientation $orientation
)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_legend_set_default_position (
  SlopeLegend $self,
  uint32 $position # SlopeLegendPosition $position
)
  is native(slope)
  is export
  { * }

sub slope_legend_set_position (SlopeLegend $self, gdouble $x, gdouble $y)
  is native(slope)
  is export
  { * }

sub slope_legend_get_anchor (SlopeLegend $self)
  returns uint32 # SlopeCorner
  is native(slope)
  is export
  { * }

sub slope_legend_get_fill_color (SlopeLegend $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_legend_get_orientation (SlopeLegend $self)
  returns uint32 # SlopeOrientation
  is native(slope)
  is export
  { * }

sub slope_legend_get_stroke_color (SlopeLegend $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_legend_get_stroke_width (SlopeLegend $self)
  returns gdouble
  is native(slope)
  is export
  { * }

sub slope_legend_set_anchor (
  SlopeLegend $self,
  uint32 $corner # SlopeCorner $anchor
)
  is native(slope)
  is export
  { * }

sub slope_legend_set_fill_color (SlopeLegend $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_legend_set_orientation (
  SlopeLegend $self,
  uint32 $orientation # SlopeOrientation $orientation
)
  is native(slope)
  is export
  { * }

sub slope_legend_set_stroke_color (SlopeLegend $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_legend_set_stroke_width (SlopeLegend $self, gdouble $width)
  is native(slope)
  is export
  { * }
