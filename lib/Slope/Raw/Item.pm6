use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::Item;

sub slope_item_add_subitem (SlopeItem $self, SlopeItem $subitem)
  is native(slope)
  is export
  { * }

sub slope_item_detach (SlopeItem $self)
  is native(slope)
  is export
  { * }

sub slope_item_get_data_rect (SlopeItem $self, SlopeRect $rect)
  is native(slope)
  is export
  { * }

sub slope_item_get_figure (SlopeItem $self)
  returns SlopeFigure
  is native(slope)
  is export
  { * }

sub slope_item_get_figure_rect (SlopeItem $self, SlopeRect $rect)
  is native(slope)
  is export
  { * }

sub slope_item_get_is_managed (SlopeItem $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_item_get_is_visible (SlopeItem $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_item_get_name (SlopeItem $self)
  returns char
  is native(slope)
  is export
  { * }

sub slope_item_get_scale (SlopeItem $self)
  returns SlopeScale
  is native(slope)
  is export
  { * }

sub slope_item_get_sub_item (SlopeItem $self, Str $name)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_item_get_subitem_list (SlopeItem $self)
  returns GList
  is native(slope)
  is export
  { * }

sub slope_item_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_item_get_view (SlopeItem $self)
  returns SlopeView
  is native(slope)
  is export
  { * }

sub slope_item_set_is_managed (SlopeItem $self, gboolean $managed)
  is native(slope)
  is export
  { * }

sub slope_item_set_is_visible (SlopeItem $self, gboolean $visible)
  is native(slope)
  is export
  { * }

sub slope_item_set_name (SlopeItem $self, Str $name)
  is native(slope)
  is export
  { * }
