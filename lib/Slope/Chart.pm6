use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Raw::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use GTK::Window

our subset ChartAncestry is export of Mu where SlopeChart | WindowAncestry;

class Slope::Chart is GTK::Window {
  has SlopeChart $!c;
  
  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }
  
  submethod BUILD (:$chart) {
    self.setWindow( cast(GtkWindow, $!c = $chart) ;
  }
  
  method new {
    self.bless( chart => slope_chart_new() );
  }
  
  method new_detailed (Int() $width, Int() $height) is also<new-detailed> {
    my gint ($w, $h) = resolve-int($width, $height);
    self.bless( chart => slope_chart_new_detailed($!c, $width, $height) );
  }
  
  method add_scale (SlopeScale $scale) is also<add-scale> {
    slope_chart_add_scale($!c, $scale);
  }

  method get_figure is also<get-figure> {
    slope_chart_get_figure($!c);
  }

  method get_header is also<get-header> {
    slope_chart_get_header($!c);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_chart_get_type, $n, $t );
  }

  method get_view is also<get-view> {
    slope_chart_get_view($!c);
  }

  method redraw {
    slope_chart_redraw($!c);
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height) 
    is also<write-to-png> 
  {
    my gint ($w, $h) = resolve-int($width, $height);
    slope_chart_write_to_png($!c, $filename, $w, $h);
  }

}
