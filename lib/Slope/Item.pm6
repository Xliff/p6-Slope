use v6.c;

use Method::Also;


use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::Item;

use GLib::GList;

use Slope::Figure;
use Slope::Scale;

use GLib::Roles::Object;
use GLib::Roles::ListData;
use GTK::Roles::Protection;

our subset SlopeItemAncestry is export of Mu
  where SlopeItem | GObject;

class Slope::Item {
  also does GLib::Roles::Object;
  also does GTK::Roles::Protection;

  has SlopeItem $!i is implementor;

  submethod BUILD (:$item) {
    self.ADD-PREFIX('Slope::');

    self.setItem($item) if $item;
  }

  method Slope::Raw::Types::SlopeItem
    is also<SlopeItem>
  { $!i }

  method setItem (SlopeItem $item) {
    self.IS-PROTECTED;

    $!i = $item;

    self.roleInit-Object;
  }

  method new (SlopeItem $item) {
    return unless $item;

    self.bless(:$item);
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_item_get_is_managed($!i);
      },
      STORE => sub ($, Int() $managed is copy) {
        my gboolean $m = $managed.so.Int;

        slope_item_set_is_managed($!i, $m);
      }
    );
  }

  method is_visible is rw is also<is-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_item_get_is_visible($!i);
      },
      STORE => sub ($, $visible is copy) {
        my gboolean $v = $visible.so.Int;

        slope_item_set_is_visible($!i, $v);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        slope_item_get_name($!i);
      },
      STORE => sub ($, Str() $name is copy) {
        slope_item_set_name($!i, $name);
      }
    );
  }

  method add_subitem (SlopeItem() $subitem) is also<add-subitem> {
    slope_item_add_subitem($!i, $subitem);
  }

  method detach {
    slope_item_detach($!i);
  }

  method get_data_rect (SlopeRect $rect) is also<get-data-rect> {
    slope_item_get_data_rect($!i, $rect);
  }

  method get_figure (:$raw = False) is also<get-figure> {
    my $f = slope_item_get_figure($!i);

    $f ??
      ( $raw ?? $f !! Slope::Figure.new($f) )
      !!
      Nil;
  }

  method get_figure_rect (SlopeRect $rect) is also<get-figure-rect> {
    slope_item_get_figure_rect($!i, $rect);
  }

  method get_scale (:$raw = False) is also<get-scale> {
    my $s = slope_item_get_scale($!i);

    $s ??
      ( $raw ?? $s !! Slope::Scale.new($s) )
      !!
      Nil;
  }

  method get_sub_item (Str() $name, :$raw = False) is also<get-sub-item> {
    my $i = slope_item_get_sub_item($!i, $name);

    $i ??
      ( $raw ?? $i !! Slope::Item.new($i) )
      !!
      Nil;
  }

  method get_subitem_list (:$glist = False, :$raw = False)
    is also<get-subitem-list>
  {
    my $sl = slope_item_get_subitem_list($!i);

    return Nil unless $sl;
    return $sl if     $glist;

    $sl = GLib::GList.new($sl)
      but GTK::Compat::Roles::GListData[SlopeItem];

    $raw ?? $sl.Array !! $sl.Array.map({ Slope::Item.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_item_get_type, $n, $t );
  }

  method get_view (:$raw = False) is also<get-view> {
    my $v = slope_item_get_view($!i);

    $v ??
      ( $raw ?? $v !! Slope::View.new($v) )
      !!
      Nil;
  }

}
