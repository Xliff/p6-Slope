use v6.c;

use Method::Also;

use Slope::Raw::Types;
use Slope::Raw::View;

use GTK::DrawingArea;
use Slope::Figure;

our subset SlopeViewAncestry is export of Mu
  where SlopeView | DrawingAreaAncestry;

class Slope::View is GTK::DrawingArea {
  has SlopeView $!v;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD (:$view) {
    self.setSlopeView($view);
  }

  method setSlopeView (SlopeViewAncestry $_) {
    my $to-parent;

    $!v = do {
      when SlopeView {
        $to-parent = cast(GtkDrawingArea, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SlopeView, $_);
      }
    }
    self.setDrawingArea($to-parent);
  }

  method Slope::Raw::Definitions::SlopeView
    is also<SlopeView>
  { $!v }

  multi method new (SlopeViewAncestry $view) {
    $view ?? self.bless(:$view) !! Nil;
  }
  multi method new {
    my $view = slope_view_new();

    $view ?? self.bless(:$view) !! Nil;
  }

  method new_with_figure (SlopeFigure() $figure) is also<new-with-figure> {
    my $view = slope_view_new_with_figure($figure);

    $view ?? self.bless(:$view) !! Nil;
  }

  method figure (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $f = slope_view_get_figure($!v);

        $f ??
          ( $raw ?? $f !! Slope::Figure.new($f) )
          !!
          Nil;
      },
      STORE => sub ($, SlopeFigure() $figure is copy) {
        slope_view_set_figure($!v, $figure);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_view_get_type, $n, $t );
  }

  method redraw {
    slope_view_redraw($!v);
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height)
    is also<write-to-png>
  {
    my gint ($w, $h) = ($w, $h);

    slope_view_write_to_png($!v, $filename, $w, $h);
  }

}
