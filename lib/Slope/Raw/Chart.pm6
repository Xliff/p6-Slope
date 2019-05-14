use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;
use Slope::Raw::Types;

unit package Slope::Raw::Chart;

sub slope_chart_add_scale (SlopeChart $self, SlopeScale $scale)
  is native(slope)
  is export
{ * }

sub slope_chart_get_figure (SlopeChart $self)
  returns SlopeFigure
  is native(slope)
  is export
{ * }

sub slope_chart_get_header (SlopeChart $self)
  returns GtkWidget
  is native(slope)
  is export
{ * }

sub slope_chart_get_type ()
  returns GType
  is native(slope)
  is export
{ * }

sub slope_chart_get_view (SlopeChart $self)
  returns SlopeView
  is native(slope)
  is export
{ * }

sub slope_chart_new ()
  returns SlopeChart
  is native(slope)
  is export
{ * }

sub slope_chart_new_detailed (Str $title, int32 $width, int32 $height)
  returns SlopeChart
  is native(slope)
  is export
{ * }

sub slope_chart_redraw (SlopeChart $self)
  is native(slope)
  is export
{ * }

sub slope_chart_write_to_png (SlopeChart $self, Str $filename, int32 $width, int32 $height)
  is native(slope)
  is export
{ * }
