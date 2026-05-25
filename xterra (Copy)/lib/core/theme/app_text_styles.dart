import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _font = 'Inter';

  // ── Brand / Logo ────────────────────────────────────────────────────────────
  static TextStyle get logoTitle => TextStyle(
    fontFamily: _font,
    color: AppColors.white,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );

  // ── Page titles ─────────────────────────────────────────────────────────────
  static TextStyle get pageTitle => TextStyle(
    fontFamily: _font,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle get sheetTitle => TextStyle(
    fontFamily: _font,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // ── Labels ──────────────────────────────────────────────────────────────────
  static TextStyle get fieldLabel => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.labelText,
    fontWeight: FontWeight.w500,
  );

  // ── Input field ─────────────────────────────────────────────────────────────
  static TextStyle get fieldText => TextStyle(
    fontFamily: _font,
    fontSize: 15.sp,
    color: AppColors.primary,
  );

  static TextStyle get fieldHint => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.hintText,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get searchText => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.primary,
  );

  // ── Country picker chip ─────────────────────────────────────────────────────
  static TextStyle get pickerFlag => TextStyle(
    fontFamily: _font,
    fontSize: 20.sp,
  );

  static TextStyle get pickerDialCode => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // ── Country list ────────────────────────────────────────────────────────────
  static TextStyle get listFlag => TextStyle(
    fontFamily: _font,
    fontSize: 24.sp,
  );

  static TextStyle countryName({bool selected = false}) => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
    color: AppColors.primary,
  );

  static TextStyle get countryDialCode => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.secondaryText,
    fontWeight: FontWeight.w500,
  );

  // ── OTP Verify ──────────────────────────────────────────────────────────────
  static TextStyle get otpSentText => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.secondaryText,
  );

  static TextStyle get otpDigit => TextStyle(
    fontFamily: _font,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get otpStatus => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.secondaryText,
  );

  // ── Terms ────────────────────────────────────────────────────────────────────
  static TextStyle get termsText => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.labelText,
    height: 1.5,
  );

  static TextStyle get termsLink => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.labelText,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.labelText,
    height: 1.5,
  );

  // ── Success ──────────────────────────────────────────────────────────────────
  static TextStyle get successLabel => TextStyle(
    fontFamily: _font,
    fontSize: 16.sp,
    color: AppColors.secondaryText,
  );

  // ── Register ─────────────────────────────────────────────────────────────────
  static TextStyle get welcomeTitle => TextStyle(
    fontFamily: _font,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle get welcomeSubtitle => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.secondaryText,
  );

  static TextStyle get uploadLabel => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
  );

  static TextStyle get uploadFormat => TextStyle(
    fontFamily: _font,
    fontSize: 11.sp,
    color: AppColors.secondaryText,
  );

  static TextStyle get fileTileName => TextStyle(
    fontFamily: _font,
    fontSize: 13.sp,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get fileTileSize => TextStyle(
    fontFamily: _font,
    fontSize: 12.sp,
    color: AppColors.secondaryText,
  );

  static TextStyle get successTitle => TextStyle(
    fontFamily: _font,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    height: 1.5,
  );

  static TextStyle get successSubtitle => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  // ── Miscellaneous ────────────────────────────────────────────────────────────
  static TextStyle get orDivider => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.secondaryText,
  );

  static TextStyle get buttonLabel => TextStyle(
    fontFamily: _font,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static TextStyle get emptyStateLabel => TextStyle(
    fontFamily: _font,
    fontSize: 14.sp,
    color: AppColors.secondaryText,
  );
}
