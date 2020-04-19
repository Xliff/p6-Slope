use v6.c;

use Method::Also;

use Slope::Raw::Types;
use Slope::Raw::Scale;

use GLib::GList;
use Slope::Figure;
use Slope::View;

use GLib::Roles::ListData;
use GLib::Roles::Object;

our subset SlopeScaleAncestry is export of Mu
  where SlopeScale | GObject;

class Slope::Scale {
  also does GLib::Roles::Object;

  has SlopeScale $!s is implementor;

  submethod BUILD (:$scale) {
    self.setScale($scale) if $scale;
  }

  method setScale(SlopeScaleAncestry $_) {
    my $to-parent;

    $!s = do {
      when    SlopeScale { $_ }
      default            { cast(SlopeScale, $_) }
    }

    self.roleInit-Object;
  }

  method Slope::Raw::Types::SlopeScale
    is also<SlopeScale>
  { $!s }

  method new (SlopeScale $scale) {
    $scale ?? self.bless(:$scale) !! Nil;
  }

  method background_color is rw is also<background-color> {
    Proxy.new(
      FETCH => sub ($) {
        slope_scale_get_background_color($!s);
      },
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_scale_set_background_color($!s, $c);
      }
    );
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_scale_get_is_managed($!s);
      },
      STORE => sub ($, Int() $managed is copy) {
        my gboolean $m = $managed.so.Int;

        slope_scale_set_is_managed($!s, $m);
      }
    );
  }

  method is_visible is rw is also<is-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_scale_get_is_visible($!s);
      },
      STORE => sub ($, $visible is copy) {
        my gboolean $v = $visible.so.Int;

        slope_scale_set_is_visible($!s, $v);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_scale_get_name($!s);
      },
      STORE => sub ($, Str() $name is copy) {
        slope_scale_set_name($!s, $name);
      }
    );
  }

  method show_name is rw is also<show-name> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_scale_get_show_name($!s);
      },
      STORE => sub ($, Int() $show is copy) {
        my gboolean $s = $show.so.Int;

        slope_scale_set_show_name($!s, $s);
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

  method get_figure (:$raw = False) is also<get-figure> {
    my $f = slope_scale_get_figure($!s);

    $f ??
      ( $raw ?? $f !! Slope::Figure.new($f) )
      !!
      Nil;
  }

  method get_figure_rect (SlopeRect $rect) is also<get-figure-rect> {
    slope_scale_get_figure_rect($!s, $rect);
  }

  method get_item_by_name (Str() $itemname, :$raw = False)
    is also<get-item-by-name>
  {
    my $i = slope_scale_get_item_by_name($!s, $itemname);

    $i ??
      ( $raw ?? $i !! ::('Slope::Item').new($i) )
      !!
      Nil;
  }

  method get_item_list (:$glist = False, :$raw = False)
    is also<get-item-list>
  {
    my $il = slope_scale_get_item_list($!s);

    return Nil unless $il;
    return $il if     $glist && $raw;

    $il = GLib::GList.new($il)
        but GTK::Compat::Roles::GListData[SlopeItem];

    return $il if $glist;

    $raw ?? $il.Array !! $il.Array.map({ Slope::Item.new($_) });
  }

  method get_layout_rect (SlopeRect $rect) is also<get-layout-rect> {
    slope_scale_get_layout_rect($!s, $rect);
  }

  method get_legend (:$raw = False) is also<get-legend> {
    my $l = slope_scale_get_legend($!s);

    $l ??
      ( $raw ?? $l !! ::('Slope::Legend').new($l) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, slope_scale_get_type, $n, $t );
  }

  method get_view (:$raw = False) is also<get-view> {
    my $v = slope_scale_get_view($!s);

    $v ??
      ( $raw ?? $v !! Slope::View.new($v) )
      !!
      Nil;
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
