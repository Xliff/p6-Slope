use v6.c;

use Cairo;

use GTK::Compat::Types;
use Slope::Raw::Types;

use Slope::Raw::Figure;

class Slope::Figure {
  has SlopeFigure $!f;
  
  submethod BUILD (:$figure) {
    $!f = $figufe;
  }
  
  method new {
    self.bless( figure => slope_figure_new() );
  }
  
  method Slope::Raw::Types::SlopeFigure
    is also<
      SlopeFigure
      Figure
    >
  { $!f }
    
  method background_color is rw is also<background-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_figure_get_background_color($!f);
      },
      STORE => sub ($, $color is copy) {
        slope_figure_set_background_color($!f, $color);
      }
    );
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        slope_figure_get_is_managed($!f);
      },
      STORE => sub ($, $managed is copy) {
        slope_figure_set_is_managed($!f, $managed);
      }
    );
  }
  
  method add_scale (SlopeScale $scale) is also<add-scale> {
    slope_figure_add_scale($!f, $scale);
  }

  method draw (SlopeRect $rect, CairoObject $cr is copy) {
    $cr .= Context if $crt ~~ Cairo::Context;
    slope_figure_draw($!f, $rect, $cr);
  }

  method get_legend is also<get-legend> {
    slope_figure_get_legend($!f);
  }

  method get_scale_list is also<get-scale-list> {
    slope_figure_get_scale_list($!f);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_figure_get_type, $n, $t );
  }

  method get_view is also<get-view> {
    slope_figure_get_view($!f);
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height) 
    is also<write-to-png> 
  {
    my gint ($w, $h) = resolve-int($width, $height);
    slope_figure_write_to_png($!f, $filename, $w, $h);
  }

}
