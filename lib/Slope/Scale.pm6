use v6.c;

use GTK::Compat::Types;
use Slope::Raw::Types;

use Slope::Raw::Scale;

use GTK::Compat::Roles::Object;

class Slope::Scale {
  also does GTK::Compat::Roles::Object;

  has SlopeScale $!s;

  submethod BUILD (:$scale) {
    self!setObjet( cast(GObject, $!s = $scale) );
  }

  method new (SlopeScale $scale) {
    self.bless(:$scale);
  }

  method background_color is rw is also<background-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_scale_get_background_color($!s);
      },
      STORE => sub ($, $color is copy) {
        slope_scale_set_background_color($!s, $color);
      }
    );
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_scale_get_is_managed($!s);
      },
      STORE => sub ($, $managed is copy) {
        slope_scale_set_is_managed($!s, $managed);
      }
    );
  }

  method is_visible is rw is also<is-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_scale_get_is_visible($!s);
      },
      STORE => sub ($, $visible is copy) {
        slope_scale_set_is_visible($!s, $visible);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_scale_get_name($!s);
      },
      STORE => sub ($, $name is copy) {
        slope_scale_set_name($!s, $name);
      }
    );
  }

  method show_name is rw is also<show-name> {
    Proxy.new(
      FETCH => sub ($) {
        slope_scale_get_show_name($!s);
      },
      STORE => sub ($, $show is copy) {
        slope_scale_set_show_name($!s, $show);
      }
    );
  }

  method add_item (SlopeItem() $item) is also<add-item> {
    slope_scale_add_item($!s, $item);
  }

  method detach {
    slope_scale_detach($!s);
  }

  method get_data_rect (SlopeRect $rect) is also<get-data-rect> {
    slope_scale_get_data_rect($!s, $rect);
  }

  method get_figure is also<get-figure> {
    slope_scale_get_figure($!s);
  }

  method get_figure_rect (SlopeRect $rect) is also<get-figure-rect> {
    slope_scale_get_figure_rect($!s, $rect);
  }

  method get_item_by_name (Str() $itemname) is also<get-item-by-name> {
    slope_scale_get_item_by_name($!s, $itemname);
  }

  method get_item_list is also<get-item-list> {
    slope_scale_get_item_list($!s);
  }

  method get_layout_rect (SlopeRect $rect) is also<get-layout-rect> {
    slope_scale_get_layout_rect($!s, $rect);
  }

  method get_legend is also<get-legend> {
    slope_scale_get_legend($!s);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, slope_scale_get_type, $n, $t );
  }

  method get_view is also<get-view> {
    slope_scale_get_view($!s);
  }

  method map (SlopePoint $res, SlopePoint $src) {
    slope_scale_map($!s, $res, $src);
  }

  method remove_item (SlopeItem() $item) is also<remove-item> {
    slope_scale_remove_item($!s, $item);
  }

  method remove_item_by_name (Str() $itemname)
    is also<remove-item-by-name>
  {
    slope_scale_remove_item_by_name($!s, $itemname);
  }

  method rescale {
    slope_scale_rescale($!s);
  }

  method set_layout_rect (Num() $x, Num() $y, Num() $w, Num() $h)
    is also<set-layout-rect>
  {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $w, $h);
    slope_scale_set_layout_rect($!s, $xx, $yy, $ww, $hh);
  }

  method set_name_top_padding (Num() $padding)
    is also<set-name-top-padding>
  {
    my gdouble $p = $padding;
    slope_scale_set_name_top_padding($!s, $p);
  }

  method unmap (SlopePoint $res, SlopePoint $src) {
    slope_scale_unmap($!s, $res, $src);
  }

}
