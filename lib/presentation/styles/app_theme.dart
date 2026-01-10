import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:movieverse/main.dart';

/// Ekstensi untuk mengonversi [Color] ke nilai ARGB (int)
extension ColorToArgb on Color {
  int toArgb() =>
      ((a.toInt() << 24) | (r.toInt() << 16) | (g.toInt() << 8) | b.toInt());
}

/// Tema aplikasi menggunakan DynamicScheme dari material_color_utilities.
@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    this.primaryColor = const Color(0xFF000000),
    this.tertiaryColor = const Color(0xFF00BFFF),
    this.neutralColor = const Color(0xF5F5F5FF),
    this.cardColor = const Color(0xFF221d27),
  });

  final Color primaryColor, tertiaryColor, neutralColor, cardColor;

  final bool isDark = false;

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? primaryColor,
    Color? tertiaryColor,
    Color? neutralColor,
  }) => AppTheme(
    primaryColor: primaryColor ?? this.primaryColor,
    tertiaryColor: tertiaryColor ?? this.tertiaryColor,
    neutralColor: neutralColor ?? this.neutralColor,
  );

  ThemeData toThemeData() {
    // Buat DynamicScheme dan konversikan ke ColorScheme.
    final colorScheme = _dynamicScheme().toColorScheme(Brightness.light);
    return _base(colorScheme).copyWith(brightness: colorScheme.brightness);
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) return this;
    return AppTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      tertiaryColor: Color.lerp(tertiaryColor, other.tertiaryColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
    );
  }

  ThemeData _base(ColorScheme colorScheme) {
    TextTheme txtTheme = ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      extensions: [this],
      colorScheme: colorScheme,
      textSelectionTheme: TextSelectionThemeData(cursorColor: tertiaryColor),
      scaffoldBackgroundColor: primaryColor,
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((
          Set<WidgetState> states,
        ) {
          // Mengembalikan TextStyle yang sesuai dengan state widget
          if (states.contains(WidgetState.selected)) {
            return $styles.text.labelSmall.copyWith(color: tertiaryColor);
          } else {
            return $styles.text.labelLarge.copyWith(color: Colors.grey);
          }
        }),
      ),
      textTheme: txtTheme,
    );
  }

  /// Menghasilkan DynamicScheme berdasarkan warna–warna dasar.
  DynamicScheme _dynamicScheme() {
    // Dapatkan CorePalette dari masing–masing warna.
    final primaryCore = CorePalette.of(primaryColor.toArgb());
    final tertiaryCore = CorePalette.of(tertiaryColor.toArgb());
    final neutralCore = CorePalette.of(neutralColor.toArgb());

    return DynamicScheme(
      sourceColorArgb: primaryColor.toArgb(),
      variant: Variant
          .neutral, // Pastikan ejaannya benar ("standard", bukan "standart")
      isDark: false,
      primaryPalette: primaryCore.primary,
      secondaryPalette: primaryCore.secondary,
      tertiaryPalette: tertiaryCore.primary,
      neutralPalette: neutralCore.neutral,
      neutralVariantPalette: neutralCore.neutralVariant,
      // contrastLevel menggunakan nilai default (0.0)
    );
  }
}

/// Ekstensi untuk mengonversi DynamicScheme ke ColorScheme.
extension DynamicSchemeExtension on DynamicScheme {
  ColorScheme toColorScheme(Brightness brightness) {
    const Color txtColor = Colors.white;
    return ColorScheme(
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      primaryContainer: Color(primaryContainer),
      onPrimaryContainer: Color(onPrimaryContainer),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      tertiaryContainer: Color(tertiaryContainer),
      onTertiaryContainer: Color(onTertiaryContainer),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      outline: Color(outline),
      outlineVariant: Color(outlineVariant),
      surface: Color(surface),
      onSurface: txtColor,
      surfaceContainerHighest: Color(surfaceVariant),
      onSurfaceVariant: Color(onSurfaceVariant),
      inverseSurface: Color(inverseSurface),
      onInverseSurface: Color(inverseOnSurface),
      inversePrimary: Color(inversePrimary),
      shadow: Color(shadow),
      scrim: Color(scrim),
      surfaceTint: Color(primary),
      brightness: brightness,
    );
  }
}

class AppStyle {
  AppStyle({Size? screenSize}) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;
    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = .9; // phone
    } else {
      scale = .85; // small phone
    }
  }

  late final double scale;

  /// App Color
  final AppTheme theme = const AppTheme();

  /// Rounded edge corner radii
  late final corners = _Corners();

  late final shadows = _Shadows();

  /// Padding dan margin
  late final insets = _Insets(scale);

  // Text styles
  late final text = _Text(scale);

  /// Animation Durations
  final times = _Times();

  /// Shared sizes
  late final sizes = _Sizes();
}

class _Text {
  _Text(this._scale);
  final double _scale;

  // Font families
  final displayFont = GoogleFonts.sora();
  final baseFont = GoogleFonts.inter();

  // DISPLAY (Hero title, page title besar)
  late final displayLarge = _createFont(
    displayFont,
    sizePx: 56,
    heightPx: 64,
    weight: FontWeight.w700,
    spacingPc: -2,
  );

  late final displayMedium = _createFont(
    displayFont,
    sizePx: 44,
    heightPx: 52,
    weight: FontWeight.w600,
    spacingPc: -1.5,
  );

  late final displaySmall = _createFont(
    displayFont,
    sizePx: 36,
    heightPx: 44,
    weight: FontWeight.w600,
    spacingPc: -1,
  );

  // HEADLINE (Section title)
  late final headlineLarge = _createFont(
    baseFont,
    sizePx: 28,
    heightPx: 36,
    weight: FontWeight.w600,
    spacingPc: -0.5,
  );

  late final headlineMedium = _createFont(
    baseFont,
    sizePx: 24,
    heightPx: 32,
    weight: FontWeight.w600,
  );

  late final headlineSmall = _createFont(
    baseFont,
    sizePx: 20,
    heightPx: 28,
    weight: FontWeight.w500,
  );

  // TITLE (Card title, dialog title)
  late final titleLarge = _createFont(
    baseFont,
    sizePx: 18,
    heightPx: 24,
    weight: FontWeight.w500,
  );

  late final titleMedium = _createFont(
    baseFont,
    sizePx: 16,
    heightPx: 22,
    weight: FontWeight.w500,
  );

  late final titleSmall = _createFont(
    baseFont,
    sizePx: 14,
    heightPx: 20,
    weight: FontWeight.w500,
  );

  // BODY (Description, synopsis)
  late final bodyLarge = _createFont(
    baseFont,
    sizePx: 16,
    heightPx: 24,
    weight: FontWeight.w400,
  );

  late final bodyMedium = _createFont(
    baseFont,
    sizePx: 14,
    heightPx: 20,
    weight: FontWeight.w400,
  );

  late final bodySmall = _createFont(
    baseFont,
    sizePx: 12,
    heightPx: 18,
    weight: FontWeight.w400,
  );

  // LABEL (Button, chip, tag)
  late final labelLarge = _createFont(
    baseFont,
    sizePx: 14,
    heightPx: 20,
    weight: FontWeight.w600,
    spacingPc: 2,
  );

  late final labelMedium = _createFont(
    baseFont,
    sizePx: 12,
    heightPx: 16,
    weight: FontWeight.w600,
    spacingPc: 2,
  );

  late final labelSmall = _createFont(
    baseFont,
    sizePx: 11,
    heightPx: 16,
    weight: FontWeight.w600,
    spacingPc: 2,
  );

  TextStyle _createFont(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }

    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? heightPx / sizePx : style.height,
      letterSpacing: spacingPc != null
          ? sizePx * spacingPc * 0.01
          : style.letterSpacing,
      fontWeight: weight,
      color: Colors.white,
    );
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  final double sm = 4;
  final double md = 8;
  final double lg = 32;
}

// TODO: tambahkan @immutable jika desain sudah final
class _Sizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 250);
}

@immutable
class _Insets {
  const _Insets(this._scale);
  final double _scale;

  final double xxs = 4;
  final double xs = 8;
  final double sm = 16;
  final double md = 24;
  final double lg = 32;
  final double xl = 48;
  final double xxl = 56;
  final double offset = 80;

  // Karena nilai insets di–scale, gunakan getter untuk mengalikan scale
  double get scaledXxs => xxs * _scale;
  double get scaledXs => xs * _scale;
  double get scaledSm => sm * _scale;
  double get scaledMd => md * _scale;
  double get scaledLg => lg * _scale;
  double get scaledXl => xl * _scale;
  double get scaledXxl => xxl * _scale;
  double get scaledOffset => offset * _scale;
}

@immutable
class _Shadows {
  final List<Shadow> textSoft = [
    Shadow(
      // Menggunakan withAlpha() untuk mengatur opacity (0.25 * 255 ≈ 64)
      color: Colors.black.withAlpha((0.25 * 255).round()),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  final List<Shadow> text = [
    Shadow(
      color: Colors.black.withAlpha((0.6 * 255).round()),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];
  final List<Shadow> textStrong = [
    Shadow(
      color: Colors.black.withAlpha((0.6 * 255).round()),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}
