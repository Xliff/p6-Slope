use v6.c;

unit package Slope::Raw::Exports;

our @slope-exports is export;

BEGIN {
  @slope-exports = <
    Slope::Raw::Definitions
    Slope::Raw::Enums
    Slope::Raw::Subs
  >;
}
