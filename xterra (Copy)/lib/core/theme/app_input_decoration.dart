import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_strings.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppInputDecoration {
  AppInputDecoration._();

  // ── Phone field (login page) ────────────────────────────────────────────────
  /// Consistent grey border on all states (enabled / focused / disabled).
  static OutlineInputBorder get phoneBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.r),
    borderSide: const BorderSide(color: AppColors.inputBorder),
  );

  // ── Search field (country picker sheet) ────────────────────────────────────
  static InputDecoration get countrySearch => InputDecoration(
    hintText: AppStrings.searchCountry,
    hintStyle: AppTextStyles.fieldHint,
    prefixIcon: Icon(
      Icons.search,
      size: 20.sp,
      color: AppColors.secondaryText,
    ),
    filled: true,
    fillColor: AppColors.surfaceLight,
    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
    border: _noStrokeBorder,
    enabledBorder: _noStrokeBorder,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
  );

  static OutlineInputBorder get _noStrokeBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: BorderSide.none,
  );
}
