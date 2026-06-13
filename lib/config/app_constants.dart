import 'package:flutter/material.dart';

// ==================== COLORS ====================
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF5A4FB8);

  // Secondary Colors
  static const Color secondary = Color(0xFF00D4FF);
  static const Color secondaryLight = Color(0xFF40ECFF);
  static const Color secondaryDark = Color(0xFF00B8D4);

  // Accent Colors
  static const Color accent = Color(0xFFFFB800);
  static const Color accentLight = Color(0xFFFFC833);
  static const Color accentDark = Color(0xFFE6A200);

  // Background
  static const Color background = Color(0xFFF8FAFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F7FA);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF2196F3);

  // Card Rarity Colors
  static const Color cardCommon = Color(0xFF95989A); // Grey
  static const Color cardRare = Color(0xFF4A90E2); // Blue
  static const Color cardEpic = Color(0xFF8B5CF6); // Purple
  static const Color cardLegendary = Color(0xFFFFD700); // Gold

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Overlay
  static const Color overlay = Color(0xFF000000);
}

// ==================== SPACING ====================
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

// ==================== BORDER RADIUS ====================
class AppRadius {
  static const double small = 12;
  static const double medium = 16;
  static const double large = 20;
  static const double extraLarge = 24;
  static const double massive = 28;
  static const double circle = 50;
}

// ==================== SIZES ====================
class AppSizes {
  // Button Heights
  static const double buttonHeight = 52;
  static const double buttonHeightSmall = 44;
  static const double buttonHeightLarge = 60;

  // Avatar Sizes
  static const double avatarLarge = 80;
  static const double avatarMedium = 48;
  static const double avatarSmall = 32;

  // Icon Sizes
  static const double iconLarge = 56;
  static const double iconMedium = 40;
  static const double iconSmall = 24;

  // Card Sizes
  static const double cardElevation = 4;
  static const double cardElevationHigh = 8;
}

// ==================== SHADOW ====================
class AppShadows {
  static const BoxShadow light = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  static const BoxShadow medium = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow dark = BoxShadow(
    color: Color(0x2A000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static List<BoxShadow> getElevation(double elevation) {
    if (elevation <= 4) return [light];
    if (elevation <= 8) return [medium];
    return [dark];
  }
}

// ==================== GRADIENTS ====================
class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [AppColors.secondary, AppColors.secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [AppColors.accent, AppColors.accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF00D4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardCommonGradient = LinearGradient(
    colors: [Color(0xFF95989A), Color(0xFFB0B3B5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardRareGradient = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF6BA3FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardEpicGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFB088FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardLegendaryGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFFFED4E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ==================== DURATIONS ====================
class AppDurations {
  static const Duration extraFast = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);
}

// ==================== CURVES ====================
class AppCurves {
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;
}
