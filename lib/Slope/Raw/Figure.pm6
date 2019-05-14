use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::Figure;

sub slope_figure_add_scale (SlopeFigure $self, SlopeScale $scale)
  is native(slope)
  is export
  { * }

sub slope_figure_draw (SlopeFigure $self, SlopeRect $rect, cairo_t $cr)
  is native(slope)
  is export
  { * }

sub slope_figure_get_legend (SlopeFigure $self)
  returns SlopeItem
  is native(slope)
  is export
  { * }

sub slope_figure_get_scale_list (SlopeFigure $self)
  returns GList
  is native(slope)
  is export
  { * }

sub slope_figure_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_figure_get_view (SlopeFigure $self)
  returns SlopeView
  is native(slope)
  is export
  { * }

sub slope_figure_new ()
  returns SlopeFigure
  is native(slope)
  is export
  { * }

sub slope_figure_write_to_png (
  SlopeFigure $self,
  Str $filename,
  gint $width,
  gint $height
)
  is native(slope)
  is export
  { * }

sub slope_figure_get_background_color (SlopeFigure $self)
  returns SlopeColor
  is native(slope)
  is export
  { * }

sub slope_figure_get_is_managed (SlopeFigure $self)
  returns uint32
  is native(slope)
  is export
  { * }

sub slope_figure_set_background_color (SlopeFigure $self, SlopeColor $color)
  is native(slope)
  is export
  { * }

sub slope_figure_set_is_managed (SlopeFigure $self, gboolean $managed)
  is native(slope)
  is export
  { * }
