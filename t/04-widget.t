use v6.c;

use NativeCall;

use GTK::Compat::Types;

use Slope::Figure;
use Slope::View;
use Slope::XYScale;
use Slope::XYSeries;

use GTK::Application;
use GTK::Button;
use GTK::Box;

constant POINTS = 100;
my ($x, $y) = CArray[num64].new xx 2;

sub get_points {
  for ^POINTS { $x[$_] = rand; $y[$_] = rand; }
}

sub MAIN {
  my $app = GTK::Application.new( title => 'org.genex.slope.widget' );

  $app.activate.tap({
    my $box    = GTK::Box.new-vbox(2);
    my $btn    = GTK::Button.new_with_label('Update Plot');
    my $v      = Slope::View.new;
    my $f      = Slope::Figure.new;
    my $scale  = Slope::XYScale.new;
    get_points;
    my $series = Slope::XYSeries.new_filled(
      'Random Points', $x, $y, POINTS, 'kor'
    );

    $btn.clicked.tap({ get_points; $v.redraw; });
    $scale.add_item($series);
    $f.add_scale($scale);
    $v.figure = $f;
    $box.pack_start($v, True, True);
    $box.pack_start($btn, False, True);
    $app.window.add($box);
    $app.window.set_default_size(500, 400);

    $app.window.show_all;
  });

  $app.run;
}
