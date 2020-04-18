use v6.c;

use GLib::Raw::Definitions;

unit package Slope::Raw::Enums;

constant SlopeXyAxisComponent is export := guint32;
our enum SlopeXyAxisComponentEnum is export (
  SLOPE_XYAXIS_LINE              => 0x00000001,
  SLOPE_XYAXIS_TICKS_UP          => 0x00000002,
  SLOPE_XYAXIS_TICKS_DOWN        => 0x00000004,
  SLOPE_XYAXIS_TITLE             => 0x00000008,
  SLOPE_XYAXIS_GRID              => 0x00000010,
  SLOPE_XYAXIS_DEFAULT_UP        => 0x00000001 +| 0x00000002 +| 0x00000008,
  SLOPE_XYAXIS_DEFAULT_DOWN      => 0x00000001 +| 0x00000004 +| 0x00000008,
  SLOPE_XYAXIS_DEFAULT_UP_GRID   => 0x00000001 +| 0x00000002 +| 0x00000008 +| 0x00000010,
  SLOPE_XYAXIS_DEFAULT_DOWN_GRID => 0x00000001 +| 0x00000004 +| 0x00000008 +| 0x00000010,
  SLOPE_XYAXIS_ALL_COMPONENT     => 0xFFFFFFFF,
);

constant SlopeMouseButton is export := guint32;
our enum SlopeMouseButtonEnum is export <
  SLOPE_MOUSE_BUTTON_LEFT
  SLOPE_MOUSE_BUTTON_RIGHT
  SLOPE_MOUSE_BUTTON_NONE
>;

constant SlopeOrientation is export := guint32;
our enum SlopeOrientationEnum is export <
  SLOPE_VERTICAL
  SLOPE_HORIZONTAL
>;

constant SlopeXyScaleAxis is export := guint32;
our enum SlopeXyScaleAxisEnum is export (
  SLOPE_XYSCALE_AXIS_BOTTOM =>  0,
  SLOPE_XYSCALE_AXIS_TOP    =>  1,
  SLOPE_XYSCALE_AXIS_LEFT   =>  2,
  SLOPE_XYSCALE_AXIS_RIGHT  =>  3,
  SLOPE_XYSCALE_AXIS_X      =>  4,
  SLOPE_XYSCALE_AXIS_Y      =>  5
);

constant SlopeMouseEventType is export := guint32;
our enum SlopeMouseEventTypeEnum is export <
  SLOPE_MOUSE_PRESS
  SLOPE_MOUSE_DOUBLE_PRESS
  SLOPE_MOUSE_MOVE
  SLOPE_MOUSE_MOVE_PRESSED
  SLOPE_MOUSE_RELEASE
>;

constant SlopeLegendPosition is export := guint32;
our enum SlopeLegendPositionEnum is export <
  SLOPE_LEGEND_CUSTOM
  SLOPE_LEGEND_TOP
  SLOPE_LEGEND_BOTTOM
  SLOPE_LEGEND_LEFT
  SLOPE_LEGEND_RIGHT
  SLOPE_LEGEND_TOPLEFT
  SLOPE_LEGEND_TOPRIGHT
  SLOPE_LEGEND_BOTTOMLEFT
  SLOPE_LEGEND_BOTTOMRIGHT
>;

constant SlopeXyScaleAxisFlag is export := guint32;
our enum SlopeXyScaleAxisFlagEnum is export <
  SLOPE_XYSCALE_NO_AXIS
  SLOPE_XYSCALE_FRAME_AXIS
  SLOPE_XYSCALE_FRAME_AXIS_GRID
  SLOPE_XYSCALE_ZERO_AXIS
  SLOPE_XYSCALE_FRAME_LINE
>;

constant SlopeFigureFrameMode is export := guint32;
our enum SlopeFigureFrameModeEnum is export <
  SLOPE_FIGURE_RECTANGLE
  SLOPE_FIGURE_ROUNDRECTANGLE
>;

constant SlopeXyScaleInteracion is export := guint32;
our enum SlopeXyScaleInteracionEnum is export (
  SLOPE_XYSCALE_INTERACTION_ZOOM      =>  0,
  SLOPE_XYSCALE_INTERACTION_TRANSLATE =>  1
);

constant SlopeCorner is export := guint32;
our enum SlopeCornerEnum is export <
  SLOPE_TOPLEFT
  SLOPE_TOPRIGHT
  SLOPE_BOTTOMLEFT
  SLOPE_BOTTOMRIGHT
>;

constant SlopeSamplerMode is export := guint32;
our enum SlopeSamplerModeEnum is export <
  SLOPE_SAMPLER_MANUAL
  SLOPE_SAMPLER_AUTO_DECIMAL
>;

constant SlopeColors is export := guint32;
our enum SlopeColorsEnum is export (
  SLOPE_WHITE          => 0xFFFFFFFF,
  SLOPE_RED            => 0xFF0000FF,
  SLOPE_GREEN          => 0x00FF00FF,
  SLOPE_BLUE           => 0x0000FFFF,
  SLOPE_BLACK          => 0x000000FF,
  SLOPE_COLOR_NULL     => 0x00000000,
  SLOPE_YELLOW         => 0xFFFF00FF,
  SLOPE_CYAN           => 0x00FFFFFF,
  SLOPE_BLUEVIOLET     => 0x8A2BE2FF,
  SLOPE_BROWN          => 0xA52A2AFF,
  SLOPE_CADETBLUE      => 0x5F9EA0FF,
  SLOPE_CHOCOLATE      => 0xD2691EFF,
  SLOPE_DARKGOLDENROD  => 0xB8860BFF,
  SLOPE_DARKMAGENTA    => 0x8B008BFF,
  SLOPE_HOTPINK        => 0xFF69B4FF,
  SLOPE_LIGHTSKYBLUE   => 0x87CEFAFF,
  SLOPE_LIGHTSTEELBLUE => 0xB0C4DEFF,
  SLOPE_MIDNIGHTBLUE   => 0x191970FF,
  SLOPE_MAROON         => 0x800000FF,
  SLOPE_TEAL           => 0x008080FF,
  SLOPE_PALETURQUOISE  => 0xAFEEEEFF
);
