use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::DrawingArea;

use Slope::Figure;

our SlopeViewAncestry is export of Mu
  where SlopeView | DrawingAreaAncestry;

class Slope::View is GTK::DrawingArea {
  has SlopeView $!v;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$view) {
    self.ADD-PREFIX('Slope::');
    self.setDrawingArea( cast(GtkDrawingArea, $!v = $view) );
  }

  multi method new (SlopeViewAncestry $view) {
    self.bless(:$view);
  }
  multi method new {
    self.bless( view => lope_view_new() );
  }

  method new_with_figure (SlopeFigure() $figure) {
    self.bless( view => slope_view_new_with_figure($figure) );
  }

  method figure is rw {
    Proxy.new(
      FETCH => sub ($) {
        Slope::Figure.new( slope_view_get_figure($!v) );
      },
      STORE => sub ($, SlopeFigure() $figure is copy) {
        slope_view_set_figure($!v, $figure);
      }
    );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_view_get_type, $n, $t );
  }

  method redraw {
    slope_view_redraw($!v);
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height) {
    my gint ($w, $h) = resolve-int($w, $h);
    slope_view_write_to_png($!v, $filename, $w, $h);
  }

}
