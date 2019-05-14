use v6.c;

use Method::Also;

use GTK::Compat::Types;
use Slope::Raw::Types;

use GTK::Raw::Utils;

use Slope::Raw::Sampler;

use GTK::Compat::Roles::ListData;
use GTK::Compat::Roles::TypedBuffer;

# Boxed type.

# our @month_samples is export;
# our @pi_samples    is export;
# BEGIN {
#   my $ap;
#   $ap = $slope_sampler_month_samples_array but GTK::Compat::Roles::TypedBuffer[SlopeSample];
#   @month_samples[$_] = $ap[$_] for ^MONTH_SAMPLES;
#
#   $ap = $slope_sampler_pi_samples_array    but GTK::Compat::Roles::TypedBuffer[SlopeSample];
#   @pi_samples[$_]    = $ap[$_] for ^PI_SAMPLES;
# }

class Slope::Sampler {
  has SlopeSampler $!s;

  submethod BUILD (:$sampler) {
    $!s = $sampler;
  }

  multi method new (SlopeSampler $sampler) {
    self.bless(:$sampler);
  }
  multi method new {
    self.bless( sampler => slope_sampler_new() );
  }

  method add_sample (Num() $coord, Str() $label) is also<add-sample> {
    slope_sampler_add_sample($!s, $coord, $label);
  }

  method auto_sample_decimal (Num() $min, Num() $max, Num() $hint)
    is also<auto-sample-decimal>
  {
    my gdouble ($mn, $mx, $h) = ($min, $max, $hint);
    slope_sampler_auto_sample_decimal($!s, $mn, $mx, $h);
  }

  method clear {
    slope_sampler_clear($!s);
  }

  method destroy {
    slope_sampler_destroy($!s);
  }

  method get_mode is also<get-mode> {
    slope_sampler_get_mode($!s);
  }

  method get_sample_list is also<get-sample-list> {
    (GTK::Compat::List.new( slope_sampler_get_sample_list($!s) )
      but
     GTK::Compat::Roles::ListData[SlopeSample]).Array;
  }

  method set_samples (SlopeSample() $sample_array, Int() $n_samples)
    is also<set-samples>
  {
    my gint $ns = resolve-int($n_samples);
    slope_sampler_set_samples($!s, $sample_array, $ns);
  }

}
