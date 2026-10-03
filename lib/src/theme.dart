import 'package:flutter/material.dart';

@immutable
final class AiResponseTheme extends ThemeExtension<AiResponseTheme> {
  const AiResponseTheme({
    required this.surfaceColor,
    required this.accentColor,
    required this.codeBackgroundColor,
    required this.borderRadius,
  });

  factory AiResponseTheme.from(ColorScheme colors) => AiResponseTheme(
    surfaceColor: colors.surfaceContainerLow,
    accentColor: colors.primary,
    codeBackgroundColor: colors.surfaceContainerHighest,
    borderRadius: BorderRadius.circular(18),
  );

  final Color surfaceColor;
  final Color accentColor;
  final Color codeBackgroundColor;
  final BorderRadius borderRadius;

  @override
  AiResponseTheme copyWith({
    Color? surfaceColor,
    Color? accentColor,
    Color? codeBackgroundColor,
    BorderRadius? borderRadius,
  }) => AiResponseTheme(
    surfaceColor: surfaceColor ?? this.surfaceColor,
    accentColor: accentColor ?? this.accentColor,
    codeBackgroundColor: codeBackgroundColor ?? this.codeBackgroundColor,
    borderRadius: borderRadius ?? this.borderRadius,
  );

  @override
  AiResponseTheme lerp(covariant AiResponseTheme? other, double t) {
    if (other == null) return this;
    return AiResponseTheme(
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      codeBackgroundColor: Color.lerp(
        codeBackgroundColor,
        other.codeBackgroundColor,
        t,
      )!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }
}
