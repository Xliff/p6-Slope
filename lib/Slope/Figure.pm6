use v6.c;

use Cairo;

use Method::Also;

use GLib::GList;
use Slope::Raw::Types;
use Slope::Raw::Figure;

use GLib::Roles::Object;

class Slope::Figure {
  also does GLib::Roles::Object;

  has SlopeFigure $!f is implementor;

  submethod BUILD (:$figure) {
    $!f = $figure;

    self.roleInit-Object;
  }

  multi method new (SlopeFigure $figure) {
    $figure ?? self.bless( :$figure ) !! Nil;
  }
  multi method new {
    my $figure = slope_figure_new();

    $figure ?? self.bless( :$figure ) !! Nil;
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
      STORE => sub ($, Int() $color is copy) {
        my SlopeColor $c = $color;

        slope_figure_set_background_color($!f, $c);
      }
    );
  }

  method is_managed is rw is also<is-managed> {
    Proxy.new(
      FETCH => sub ($) {
        so slope_figure_get_is_managed($!f);
      },
      STORE => sub ($, Int() $managed is copy) {
        my gboolean $m = $managed.so.Int;

        slope_figure_set_is_managed($!f, $m);
      }
    );
  }

  method add_scale (SlopeScale() $scale) is also<add-scale> {
    slope_figure_add_scale($!f, $scale);
  }

  method draw (SlopeRect $rect, CairoObject $cr is copy) {
    $cr .= Context if $cr ~~ Cairo::Context;
    slope_figure_draw($!f, $rect, $cr);
  }

  method get_legend (:$raw = False) is also<get-legend> {
    my $l = slope_figure_get_legend($!f);

    $l ??
      ( $raw ?? $l !! ::('Slope::Legend').new($l) )
      !!
      Nil;
  }

  method get_scale_list (:$glist = False, :$raw = False)
    is also<get-scale-list>
  {
    my $sl = slope_figure_get_scale_list($!f);

    return Nil unless $sl;
    return $sl if     $glist and $raw;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[SlopeScale];

    return $sl if $glist;

    $raw ?? $sl.Array !! $sl.Array.map({ Slope::Scale.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &slope_figure_get_type, $n, $t );
  }

  method get_view (:$raw = False) is also<get-view> {
    my $v = slope_figure_get_view($!f);

    $v ??
      ( $raw ?? $v !! ::('Slope::View').new($v) )
      !!
      Nil;
  }

  method write_to_png (Str() $filename, Int() $width, Int() $height)
    is also<write-to-png>
  {
    my gint ($w, $h) = ($width, $height);

    slope_figure_write_to_png($!f, $filename, $w, $h);
  }

}
