use v6.c;

use Method::Also;
use NativeCall;

use Slope::Raw::Types;
use Slope::Raw::Sampler;

use GLib::GList;

use GLib::Roles::ListData;
use GLib::Roles::TypedBuffer;

# Boxed type.

our @month_samples is export;
our @pi_samples is export;

class Slope::Sampler {
  has SlopeSampler $!s;

  submethod BUILD (:$sampler) {
    $!s = $sampler;
  }

  multi method new (SlopeSampler $sampler) {
    return unless $sampler;

    $sampler ?? self.bless(:$sampler) !! Nil;
  }
  multi method new {
    my $sampler = slope_sampler_new();

    $sampler ?? self.bless(:$sampler) !! Nil;
  }

  method month_samples {
    return @month_samples if +@month_samples;

    @month_samples = (
      SlopeSample.new( coord =>  1.Num, label => 'Jan' ),
      SlopeSample.new( coord =>  2.Num, label => 'Feb' ),
      SlopeSample.new( coord =>  3.Num, label => 'Mar' ),
      SlopeSample.new( coord =>  4.Num, label => 'Apr' ),
      SlopeSample.new( coord =>  5.Num, label => 'May' ),
      SlopeSample.new( coord =>  6.Num, label => 'Jun' ),
      SlopeSample.new( coord =>  7.Num, label => 'Jul' ),
      SlopeSample.new( coord =>  8.Num, label => 'Oct' ),
      SlopeSample.new( coord =>  9.Num, label => 'Sep' ),
      SlopeSample.new( coord => 10.Num, label => 'Oct' ),
      SlopeSample.new( coord => 11.Num, label => 'Nov' ),
      SlopeSample.new( coord => 12.Num, label => 'Dec' )
    );
    @month_samples;

    # my $month_samples := cglobal(
    #   slope, 'slope_sampler_month_samples', Pointer
    # );
    # say $month_samples;
    # Pointer.new($month_samples + 2 * nativesizeof(SlopeSample));
  }

  method pi_samples {
    return @pi_samples if +@pi_samples;

    for ^21 {
      @pi_samples.push: SlopeSample.new(
        coord => ($_ / 2 * π).Num,
        label => do {
          when 0      { '0'   }
          when 1      { 'π/2' }
          when 2      { 'π'   }
          when * % 2  { "{ $_ }π/2" }
          default     { "{$_ div 2}π" }
        }
      );
    }
    @pi_samples;

    # my $ap = $slope_sampler_pi_samples_array
    #   but GLib::Roles::TypedBuffer[SlopeSample];
    # @pi_samples[$_] = $ap[$_] for ^PI_SAMPLES;
    # @pi_samples;
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

  method get_sample_list (:$glist = False, :$raw = False)
    is also<get-sample-list>
  {
    my $sl = slope_sampler_get_sample_list($!s);

    return Nil unless $sl;
    return $sl if     $glist && $raw;

    $sl = GLib::GList.new($sl) but GTK::Compat::Roles::GListData[SlopeSample];

    $sl.Array;
  }

  proto method set_samples (|)
    is also<set-samples>
  { * }

  multi method set_samples(@array) {
    return unless @array;

    my $buff = GLib::Roles::TypedBuffer[SlopeSample].new(@array);
    samewith($buff.p, @array.elems);
  }
  multi method set_samples (Pointer $sample_array, Int() $n_samples) {
    my gint $ns = $n_samples;

    slope_sampler_set_samples($!s, $sample_array, $ns);
  }

}
