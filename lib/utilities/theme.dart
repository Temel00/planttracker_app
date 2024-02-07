import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4286666002),
      surfaceTint: Color(4286666002),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294958518),
      onPrimaryContainer: Color(4280948736),
      secondary: Color(4282214456),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4290703538),
      onSecondaryContainer: Color(4278198786),
      tertiary: Color(4283655230),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292274617),
      onTertiaryContainer: Color(4279377667),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294965492),
      onBackground: Color(4280359443),
      surface: Color(4294965492),
      onSurface: Color(4280359443),
      surfaceVariant: Color(4293976272),
      onSurfaceVariant: Color(4283450681),
      outline: Color(4286739816),
      outlineVariant: Color(4292134068),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281741095),
      inverseOnSurface: Color(4294766306),
      inversePrimary: Color(4294425712),
      primaryFixed: Color(4294958518),
      onPrimaryFixed: Color(4280948736),
      primaryFixedDim: Color(4294425712),
      onPrimaryFixedVariant: Color(4284759808),
      secondaryFixed: Color(4290703538),
      onSecondaryFixed: Color(4278198786),
      secondaryFixedDim: Color(4288926616),
      onSecondaryFixedVariant: Color(4280700962),
      tertiaryFixed: Color(4292274617),
      onTertiaryFixed: Color(4279377667),
      tertiaryFixedDim: Color(4290432415),
      onTertiaryFixedVariant: Color(4282141736),
      surfaceDim: Color(4293253324),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963685),
      surfaceContainer: Color(4294569183),
      surfaceContainerHigh: Color(4294174426),
      surfaceContainerHighest: Color(4293779668),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4284431104),
      surfaceTint: Color(4286666002),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288375591),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280437791),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283662156),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281878565),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285102674),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294965492),
      onBackground: Color(4280359443),
      surface: Color(4294965492),
      onSurface: Color(4280359443),
      surfaceVariant: Color(4293976272),
      onSurfaceVariant: Color(4283121974),
      outline: Color(4285095249),
      outlineVariant: Color(4286937451),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281741095),
      inverseOnSurface: Color(4294766306),
      inversePrimary: Color(4294425712),
      primaryFixed: Color(4288375591),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4286468879),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283662156),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282082870),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285102674),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283523388),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293253324),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963685),
      surfaceContainer: Color(4294569183),
      surfaceContainerHigh: Color(4294174426),
      surfaceContainerHighest: Color(4293779668),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4281540096),
      surfaceTint: Color(4286666002),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284431104),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278200579),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4280437791),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279772679),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4281878565),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294965492),
      onBackground: Color(4280359443),
      surface: Color(4294965492),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4293976272),
      onSurfaceVariant: Color(4281016856),
      outline: Color(4283121974),
      outlineVariant: Color(4283121974),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281741095),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4294961361),
      primaryFixed: Color(4284431104),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282459904),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4280437791),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4278793482),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281878565),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280430864),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293253324),
      surfaceBright: Color(4294965492),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963685),
      surfaceContainer: Color(4294569183),
      surfaceContainerHigh: Color(4294174426),
      surfaceContainerHighest: Color(4293779668),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294425712),
      surfaceTint: Color(4294425712),
      onPrimary: Color(4282788352),
      primaryContainer: Color(4284759808),
      onPrimaryContainer: Color(4294958518),
      secondary: Color(4288926616),
      onSecondary: Color(4279056398),
      secondaryContainer: Color(4280700962),
      onSecondaryContainer: Color(4290703538),
      tertiary: Color(4290432415),
      onTertiary: Color(4280694036),
      tertiaryContainer: Color(4282141736),
      onTertiaryContainer: Color(4292274617),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279767564),
      onBackground: Color(4293779668),
      surface: Color(4279767564),
      onSurface: Color(4293779668),
      surfaceVariant: Color(4283450681),
      onSurfaceVariant: Color(4292134068),
      outline: Color(4288450176),
      outlineVariant: Color(4283450681),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293779668),
      inverseOnSurface: Color(4281741095),
      inversePrimary: Color(4286666002),
      primaryFixed: Color(4294958518),
      onPrimaryFixed: Color(4280948736),
      primaryFixedDim: Color(4294425712),
      onPrimaryFixedVariant: Color(4284759808),
      secondaryFixed: Color(4290703538),
      onSecondaryFixed: Color(4278198786),
      secondaryFixedDim: Color(4288926616),
      onSecondaryFixedVariant: Color(4280700962),
      tertiaryFixed: Color(4292274617),
      onTertiaryFixed: Color(4279377667),
      tertiaryFixedDim: Color(4290432415),
      onTertiaryFixedVariant: Color(4282141736),
      surfaceDim: Color(4279767564),
      surfaceBright: Color(4282398768),
      surfaceContainerLowest: Color(4279438599),
      surfaceContainerLow: Color(4280359443),
      surfaceContainer: Color(4280622615),
      surfaceContainerHigh: Color(4281346337),
      surfaceContainerHighest: Color(4282069803),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294688884),
      surfaceTint: Color(4294425712),
      onPrimary: Color(4280488704),
      primaryContainer: Color(4290479937),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4289189788),
      onSecondary: Color(4278197249),
      secondaryContainer: Color(4285439078),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4290695587),
      onTertiary: Color(4278983169),
      tertiaryContainer: Color(4286945133),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279767564),
      onBackground: Color(4293779668),
      surface: Color(4279767564),
      onSurface: Color(4294966007),
      surfaceVariant: Color(4283450681),
      onSurfaceVariant: Color(4292397241),
      outline: Color(4289699986),
      outlineVariant: Color(4287529331),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293779668),
      inverseOnSurface: Color(4281346337),
      inversePrimary: Color(4284891136),
      primaryFixed: Color(4294958518),
      onPrimaryFixed: Color(4280028672),
      primaryFixedDim: Color(4294425712),
      onPrimaryFixedVariant: Color(4283314176),
      secondaryFixed: Color(4290703538),
      onSecondaryFixed: Color(4278195713),
      secondaryFixedDim: Color(4288926616),
      onSecondaryFixedVariant: Color(4279516947),
      tertiaryFixed: Color(4292274617),
      onTertiaryFixed: Color(4278719488),
      tertiaryFixedDim: Color(4290432415),
      onTertiaryFixedVariant: Color(4281088793),
      surfaceDim: Color(4279767564),
      surfaceBright: Color(4282398768),
      surfaceContainerLowest: Color(4279438599),
      surfaceContainerLow: Color(4280359443),
      surfaceContainer: Color(4280622615),
      surfaceContainerHigh: Color(4281346337),
      surfaceContainerHighest: Color(4282069803),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294966007),
      surfaceTint: Color(4294425712),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294688884),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294049769),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4289189788),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294246367),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4290695587),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279767564),
      onBackground: Color(4293779668),
      surface: Color(4279767564),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4283450681),
      onSurfaceVariant: Color(4294966007),
      outline: Color(4292397241),
      outlineVariant: Color(4292397241),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293779668),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4282197248),
      primaryFixed: Color(4294959810),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294688884),
      onPrimaryFixedVariant: Color(4280488704),
      secondaryFixed: Color(4290966710),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4289189788),
      onSecondaryFixedVariant: Color(4278197249),
      tertiaryFixed: Color(4292538046),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4290695587),
      onTertiaryFixedVariant: Color(4278983169),
      surfaceDim: Color(4279767564),
      surfaceBright: Color(4282398768),
      surfaceContainerLowest: Color(4279438599),
      surfaceContainerLow: Color(4280359443),
      surfaceContainer: Color(4280622615),
      surfaceContainerHigh: Color(4281346337),
      surfaceContainerHighest: Color(4282069803),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
