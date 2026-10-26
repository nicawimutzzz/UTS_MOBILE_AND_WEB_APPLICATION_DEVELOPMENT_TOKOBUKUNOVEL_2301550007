import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );

  static final ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.primary,
    side: BorderSide(color: AppColors.primary, width: 1.5),
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );

  static final ButtonStyle outline = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: BorderSide(color: AppColors.primary, width: 1.5),
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle error = ElevatedButton.styleFrom(
    backgroundColor: AppColors.error,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );

  static final ButtonStyle disabled = ElevatedButton.styleFrom(
    backgroundColor: AppColors.border,
    foregroundColor: AppColors.textSecondary,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );
}
