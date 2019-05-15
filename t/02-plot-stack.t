use v6.c;

use Slope::Raw::Types;

use GTK::Application;

use Slope::Chart;
use Slope::XYScale;
use Slope::XYSeries;

constant POINTS = 50;
constant DX = 4 * π / POINTS;

sub MAIN {
  my $app = GTK::Application.new( title => 'org.genex.slope.plot_stack' );

  $app.activate.tap({
    $app.wait-for-init;

    my $chart = Slope::Chart.new;

    my (@xy1, @xy2, @xy3, $axis, $sampler);
    for (^POINTS) {
      my $x = $_ * DX;
      @xy1.push: ($x, $x.sin);
      @xy2.push: ($x, $x.cos);
      @xy3.push: ($x, 1 + @xy1[*-1][1] + 0.1 * $_);
    }

    my $scale1 = Slope::XYScale.new_axis(
      'Phase', 'Amplitude', 'Sinusoidal Functions'
    );
    $scale1.set_layout_rect(0, 0, 1, 1);
    $chart.add_scale($scale1);
    $axis = $scale1.get_axis(SLOPE_XYSCALE_AXIS_BOTTOM);
    $axis.get_sampler.set_samples(Slope::Sampler.pi_samples[^9]);

    my $scale2 = Slope::XYScale.new_axis('Month', 'Value', 'Projected Profit');
    $scale2.set_layout_rect(0, 1, 1, 1);
    $chart.add_scale($scale2);
    $axis = $scale2.get_axis(SLOPE_XYSCALE_AXIS_BOTTOM);
    $axis.get_sampler.set_samples(Slope::Sampler.month_samples);

    my $series11 = Slope::XYSeries.new_filled('Sine', @xy1, 'r-');
    $scale1.add_item($series11);
    my $series12 = Slope::XYSeries.new_filled('Cosine', @xy2, 'ga');
    $scale1.add_item($series12);

    my $series2 = Slope::XYSeries.new_filled('Sine + Linear', @xy3, 'kob');
    $scale2.add_item($series2);

    $chart.show_all;
    $chart.destroy-signal.tap({ $app.exit });
  });

  $app.run;
}
