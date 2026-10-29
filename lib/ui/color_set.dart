import 'package:flutter/material.dart';

typedef ColorSetGetter = Color Function(ColorScheme colors);

@immutable
abstract class ColorSet {
  static const primary = ColorSet(_getPrimaryBackground, _getPrimaryForeground);
  static const primaryContainer = ColorSet(
    _getPrimaryContainerBackground,
    _getPrimaryContainerForeground,
  );
  static const primaryFixed = ColorSet(
    _getPrimaryFixedBackground,
    _getPrimaryFixedForeground,
  );
  static const secondary = ColorSet(
    _getSecondaryBackground,
    _getSecondaryForeground,
  );
  static const secondaryContainer = ColorSet(
    _getSecondaryContainerBackground,
    _getSecondaryContainerForeground,
  );
  static const secondaryFixed = ColorSet(
    _getSecondaryFixedBackground,
    _getSecondaryFixedForeground,
  );
  static const surface = ColorSet(_getSurfaceBackground, _getSurfaceForeground);
  static const surfaceContainer = ColorSet(
    _getSurfaceContainerBackground,
    _getSurfaceContainerForeground,
  );
  static const inverseSurface = ColorSet(
    _getInverseSurfaceBackground,
    _getInverseSurfaceForeground,
  );
  static const tertiary = ColorSet(
    _getTertiaryBackground,
    _getTertiaryForeground,
  );
  static const tertiaryContainer = ColorSet(
    _getTertiaryContainerBackground,
    _getTertiaryContainerForeground,
  );
  static const tertiaryFixed = ColorSet(
    _getTertiaryFixedBackground,
    _getTertiaryFixedForeground,
  );
  static const error = ColorSet(_getErrorBackground, _getErrorForeground);
  static const errorContainer = ColorSet(
    _getErrorContainerBackground,
    _getErrorContainerForeground,
  );

  const factory ColorSet(
    ColorSetGetter getBackground,
    ColorSetGetter getForeground,
  ) = _ColorSet;

  const factory ColorSet.static(Color background, Color foreground) =
      _StaticColorSet;

  const ColorSet._();

  Color getBackground(ColorScheme colors);

  Color getForeground(ColorScheme colors);
}

extension ColorSetExtensions on ColorSet {
  ColorSet get inverse => this is _InverseColorSet
      ? (this as _InverseColorSet)._src
      : _InverseColorSet(this);

  (Color foreground, Color background) getColors(ColorScheme colors) =>
      (getForeground(colors), getBackground(colors));
}

class _StaticColorSet extends ColorSet {
  final Color _bg, _fg;

  const _StaticColorSet(this._bg, this._fg) : super._();

  @override
  getBackground(_) => _bg;

  @override
  getForeground(_) => _fg;
}

class _ColorSet extends ColorSet {
  final ColorSetGetter _bg;
  final ColorSetGetter _fg;

  const _ColorSet(this._bg, this._fg) : super._();

  @override
  getBackground(colors) => _bg(colors);

  @override
  getForeground(colors) => _fg(colors);
}

class _InverseColorSet extends ColorSet {
  final ColorSet _src;

  const _InverseColorSet(this._src) : super._();

  @override
  getBackground(colors) => _src.getForeground(colors);

  @override
  getForeground(colors) => _src.getBackground(colors);
}

Color _getPrimaryBackground(ColorScheme colors) => colors.primary;

Color _getPrimaryForeground(ColorScheme colors) => colors.onPrimary;

Color _getPrimaryContainerBackground(ColorScheme colors) =>
    colors.primaryContainer;

Color _getPrimaryContainerForeground(ColorScheme colors) =>
    colors.onPrimaryContainer;

Color _getPrimaryFixedBackground(ColorScheme colors) => colors.primaryFixed;

Color _getPrimaryFixedForeground(ColorScheme colors) => colors.onPrimaryFixed;

Color _getSecondaryBackground(ColorScheme colors) => colors.secondary;

Color _getSecondaryForeground(ColorScheme colors) => colors.onSecondary;

Color _getSecondaryContainerBackground(ColorScheme colors) =>
    colors.secondaryContainer;

Color _getSecondaryContainerForeground(ColorScheme colors) =>
    colors.onSecondaryContainer;

Color _getSecondaryFixedBackground(ColorScheme colors) => colors.secondaryFixed;

Color _getSecondaryFixedForeground(ColorScheme colors) =>
    colors.onSecondaryFixed;

Color _getSurfaceBackground(ColorScheme colors) => colors.surface;

Color _getSurfaceForeground(ColorScheme colors) => colors.onSurface;

Color _getSurfaceContainerBackground(ColorScheme colors) =>
    colors.surfaceContainer;

Color _getSurfaceContainerForeground(ColorScheme colors) => colors.onSurface;

Color _getInverseSurfaceBackground(ColorScheme colors) => colors.inverseSurface;

Color _getInverseSurfaceForeground(ColorScheme colors) =>
    colors.onInverseSurface;

Color _getTertiaryBackground(ColorScheme colors) => colors.tertiary;

Color _getTertiaryForeground(ColorScheme colors) => colors.onTertiary;

Color _getTertiaryContainerBackground(ColorScheme colors) =>
    colors.tertiaryContainer;

Color _getTertiaryContainerForeground(ColorScheme colors) =>
    colors.onTertiaryContainer;

Color _getTertiaryFixedBackground(ColorScheme colors) => colors.tertiaryFixed;

Color _getTertiaryFixedForeground(ColorScheme colors) => colors.onTertiaryFixed;

Color _getErrorBackground(ColorScheme colors) => colors.error;

Color _getErrorForeground(ColorScheme colors) => colors.onError;

Color _getErrorContainerBackground(ColorScheme colors) => colors.errorContainer;

Color _getErrorContainerForeground(ColorScheme colors) =>
    colors.onErrorContainer;
