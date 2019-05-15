use v6.c;

use GTK::Application;

use Slope::Chart;
use Slope::Item;
use Slope::XYScale;
use Slope::XYSeries;

constant POINTS = 50;
constant DX = 4 * π / POINTS;

sub MAIN {
  GTK::Application.init;

  my $app = GTK::Application.new(
    title       => 'org.genex.slope.simple'
  );

  $app.activate.tap({
    $app.wait-for-init;

    my $chart = Slope::Chart.new;
    my @xy = (^POINTS).eager.map({ my $x = $_ * DX; ($x.Num, sin($x).Num) });

    my $scale = Slope::XYScale.new;
    $chart.add_scale($scale);

    my $series = Slope::XYSeries.new_filled('Sine', @xy, 'kOr');
    $scale.add_item($series);

    $chart.destroy-signal.tap({ $app.exit });
    $chart.show_all;
  });

  $app.run;
}
