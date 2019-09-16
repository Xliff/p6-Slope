use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::Item;

use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::ListData;
use GTK::Roles::Protection;

use Slope::Figure;
use Slope::Scale;

our subset SlopeItemAncestry is export of Mu
  where SlopeItem | GObject;

class Slope::Item {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Protection;

  has SlopeItem $!i;

  submethod BUILD (:$item) {
    self.ADD-PREFIX('Slope::');
    self.setItem($item) with $item;
  }

  method Slope::Raw::Types::SlopeItem
    is also<SlopeItem>
  { $!i }

  method setItem (SlopeItem $item) {
    self.IS-PROTECTED;
    self!setObject($!i = $item);
  }

  method new (SlopeItem $item) {
    self.bless(:$item);
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_item_get_is_managed($!i);
      },
      STORE => sub ($, Int() $managed is copy) {
        my gboolean $m = resolve-bool($managed);
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
        my gboolean $v = resolve-bool($visible);
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

  method get_figure is also<get-figure> {
    Slope::Figure.new( slope_item_get_figure($!i) );
  }

  method get_figure_rect (SlopeRect $rect) is also<get-figure-rect> {
    slope_item_get_figure_rect($!i, $rect);
  }

  method get_scale is also<get-scale> {
    Slope::Scale.new( slope_item_get_scale($!i) );
  }

  method get_sub_item (Str() $name) is also<get-sub-item> {
    Slope::Item.new( slope_item_get_sub_item($!i, $name) );
  }

  method get_subitem_list (:$raw = False) is also<get-subitem-list> {
    my $l = GTK::Compat::List.new( slope_item_get_subitem_list($!i) )
      but GTK::Compat::Roles::ListData[SlopeItem];

    do if $l {
      ( $raw ??
        $l.Array !!
        $l.Array.map({ Slope::Item.new( $_ ) }) );
      Nil
    } else {
      Nil;
    }
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &slope_item_get_type, $n, $t );
  }

  method get_view is also<get-view> {
    Slope::View.new( slope_item_get_view($!i) );
  }

}
