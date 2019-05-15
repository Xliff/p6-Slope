use v6.c;

use Slope::Raw::Types;

use GTK::Compat::Types;
use GTK::Raw::Utils;

use GTK::Application;

use Slope::Chart;
use Slope::XYScale;
use Slope::XYSeries;

use GTK::Compat::Threads;

# Pushing this to 200 seems to cause the event loop to go too long.
constant POINTS = 100;
constant DX = 4 * π / POINTS;
my (@x, $chart, $series);

sub on_tick (--> int32) {
  state $c = 0;
  CATCH { default { .message.say } }

  my @y = (^POINTS).eager.map({
    sin(@x[$_] + 0.1 * $c) + sin(1.2 * @x[$_] - 0.1 * $c)
  }) for ^POINTS;
  $c++;
  $series.set_data(@x, @y);
  $chart.redraw;
  1;
}

sub MAIN {
  my $app = GTK::Application.new( title => 'org.genex.slope.animation' );

  $app.activate.tap({
    CATCH { default { .message.say } }

    my @y;
    (@x[$_], @y[$_]) = ( $_ * DX , 2.5 * ($_ * DX).sin ) for ^POINTS;

    $chart = Slope::Chart.new;
    my $scale = Slope::XYScale.new;
    $chart.add_scale($scale);

    $series = Slope::XYSeries.new_filled('Wave', @x, @y, 'b-');
    $scale.add_item($series);
    $chart.destroy-signal.tap({ $app.exit });
    $chart.show_all;

    # Must allow time for GTK to leave the activate thread.
    $*SCHEDULER.cue({
      say "Starting...";
      GTK::Compat::Threads.add_timeout(30, -> $ --> guint { on_tick });
    }, in => 0.1);
  });

  $app.run;
}
