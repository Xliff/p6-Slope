use v6.c;

use Method::Also;

use Slope::Raw::Chart;
use Slope::Raw::Types;

use GTK::Window;
use GTK::Widget;
use Slope::Figure;

our subset SlopeChartAncestry is export of Mu
  where SlopeChart | WindowAncestry;

class Slope::Chart is GTK::Window {
  has SlopeChart $!c;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$chart) {
    self.setSlopeChart($chart);
  }

  method setSlopeChart (SlopeChartAncestry $_) {
    my $to-parent;

    $!c = do {
      when SlopeChart {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(SlopeChart, $_);
      }
    }
    self.setWindow($to-parent);
  }

  multi method new (SlopeChartAncestry $chart) {
    $chart ?? self.bless( :$chart ) !! Nil;
  }
  multi method new {
    my $chart = slope_chart_new();

    $chart ?? self.bless( :$chart ) !! Nil;
  }

  method new_detailed (Str() $title, Int() $width, Int() $height)
    is also<new-detailed>
  {
    my gint ($w, $h) = ($width, $height);
    my $chart = slope_chart_new_detailed($title, $width, $height);

    $chart ?? self.bless( :$chart ) !! Nil;
  }

  method add_scale (SlopeScale() $scale) is also<add-scale> {
    slope_chart_add_scale($!c, $scale);
  }

  method get_figure (:$raw = False) is also<get-figure> {
    my $f = slope_chart_get_figure($!c);

    $f ??
      ( $raw ?? $f !! Slope::Figure.new($f) )
      !!
      Nil;
  }
multi
  method get_header (:$raw = False, :$widget = False) is also<get-header> {
    my $h = slope_chart_get_header($!c);

    ReturnWidget($h, $raw, $widget);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_chart_get_type, $n, $t );
  }

  method get_view (:$raw = False, :$widget = False) is also<get-view> {
    my $v = slope_chart_get_view($!c);

    ReturnWidget($v, $raw, $widget);
  }

  method redraw {
    slope_chart_redraw($!c);
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height)
    is also<write-to-png>
  {
    my gint ($w, $h) = ($width, $height);

    slope_chart_write_to_png($!c, $filename, $w, $h);
  }

}
