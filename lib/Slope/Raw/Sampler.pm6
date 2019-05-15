use v6.c;

use NativeCall;

use GTK::Compat::Types;
use Slope::Raw::Types;

unit package Slope::Raw::Sampler;

sub slope_sampler_add_sample (SlopeSampler $self, gdouble $coord, Str $label)
  is native(slope)
  is export
  { * }

sub slope_sampler_auto_sample_decimal (
  SlopeSampler $self,
  gdouble $min,
  gdouble $max,
  gdouble $hint
)
  is native(slope)
  is export
  { * }

sub slope_sampler_clear (SlopeSampler $self)
  is native(slope)
  is export
  { * }

sub slope_sampler_destroy (SlopeSampler $self)
  is native(slope)
  is export
  { * }

sub slope_sampler_get_mode (SlopeSampler $self)
  returns guint32
  is native(slope)
  is export
  { * }

sub slope_sampler_get_sample_list (SlopeSampler $self)
  returns GList
  is native(slope)
  is export
  { * }

sub slope_sampler_new ()
  returns SlopeSampler
  is native(slope)
  is export
  { * }

sub slope_sampler_set_samples (
  SlopeSampler $self,
  Pointer $sample_array,
  gint $n_samples
)
  is native(slope)
  is export
  { * }

our constant MONTH_SAMPLES is export = 12;
our $month_samples := cglobal(
  slope, 'slope_sampler_month_samples_array', Pointer
);

our constant PI_SAMPLES    is export = 21;
our $pi_samples := cglobal(
  slope, 'slope_sampler_pi_samples_array', Pointer
);
