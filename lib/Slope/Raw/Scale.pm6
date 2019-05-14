use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

sub slope_scale_add_item (SlopeScale $self, SlopeItem $item)
  is native(slope)
  is export
  { * }

sub slope_scale_detach (SlopeScale $self)
  is native(slope)
  is export
  { * }

sub slope_scale_get_data_rect (SlopeScale $self, SlopeRect $rect)
  is native(slope)
  is export
  { * }

sub slope_scale_get_figure (SlopeScale $self)
  returns SlopeFigure
  is native(slope)
  is export
  { * }

sub slope_scale_get_figure_rect (SlopeScale $self, SlopeRect $rect)
  is native(slope)
  is export
  { * }

sub slope_scale_get_item_by_name (SlopeScale $self, Str $itemname)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_scale_get_item_list (SlopeScale $self)
  returns GList
  is native(slope)
  is export
  { * }

sub slope_scale_get_layout_rect (SlopeScale $self, SlopeRect $rect)
  is native(slope)
  is export
  { * }

sub slope_scale_get_legend (SlopeScale $self)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_scale_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_scale_get_view (SlopeScale $self)
  returns SlopeView
  is native(slope)
  is export
  { * }

sub slope_scale_map (SlopeScale $self, SlopePoint $res, SlopePoint $src)
  is native(slope)
  is export
  { * }

sub slope_scale_remove_item (SlopeScale $self, SlopeItem $item)
  is native(slope)
  is export
  { * }

sub slope_scale_remove_item_by_name (SlopeScale $self, Str $itemname)
  is native(slope)
  is export
  { * }

sub slope_scale_rescale (SlopeScale $self)
  is native(slope)
  is export
  { * }

sub slope_scale_set_layout_rect (
  SlopeScale $self,
  gdouble $x,
  gdouble $y,
  gdouble $w,
  gdouble $h
)
  is native(slope)
  is export
  { * }

sub slope_scale_set_name_top_padding (SlopeScale $self, gdouble $padding)
  is native(slope)
  is export
  { * }

sub slope_scale_unmap (SlopeScale $self, SlopePoint $res, SlopePoint $src)
  is native(slope)
  is export
  { * }

sub slope_scale_get_background_color (SlopeScale $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_scale_get_is_managed (SlopeScale $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_scale_get_is_visible (SlopeScale $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_scale_get_name (SlopeScale $self)
  returns char
  is native(slope)
  is export
  { * }

sub slope_scale_get_show_name (SlopeScale $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_scale_set_background_color (SlopeScale $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_scale_set_is_managed (SlopeScale $self, gboolean $managed)
  is native(slope)
  is export
  { * }

sub slope_scale_set_is_visible (SlopeScale $self, gboolean $visible)
  is native(slope)
  is export
  { * }

sub slope_scale_set_name (SlopeScale $self, Str $name)
  is native(slope)
  is export
  { * }

sub slope_scale_set_show_name (SlopeScale $self, gboolean $show)
  is native(slope)
  is export
  { * }
