use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::View;

sub slope_view_get_type ()
  returns GType
  is native(slope)
  is export
  { * }

sub slope_view_new ()
  returns SlopeView
  is native(slope)
  is export
  { * }

sub slope_view_new_with_figure (SlopeFigure $figure)
  returns SlopeView
  is native(slope)
  is export
  { * }

sub slope_view_redraw (SlopeView $self)
  is native(slope)
  is export
  { * }

sub slope_view_write_to_png (
  SlopeView $self,
  Str $filename,
  gint $width,
  gint $height
)
  is native(slope)
  is export
  { * }

sub slope_view_get_figure (SlopeFigure $self)
  returns SlopeFigure
  is native(slope)
  is export
  { * }

sub slope_view_set_figure (SlopeView $self, SlopeFigure $figure)
  is native(slope)
  is export
  { * }
