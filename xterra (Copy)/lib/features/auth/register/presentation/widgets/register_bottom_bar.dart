import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class RegisterBottomBar extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;
  final VoidCallback? onBack;

  const RegisterBottomBar({
    super.key,
    required this.label,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(color: AppColors.divider, height: 1),
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: Row(
            children: [
              if (onBack != null) ...[
                Expanded(
                  flex: 1,
                  child: _BackButton(onPressed: onBack!),
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                flex: onBack != null ? 2 : 1,
                child: _PrimaryButton(
                  label: label,
                  isEnabled: isEnabled,
                  isLoading: isLoading,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text('Back', style: AppTextStyles.buttonLabel),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.disabledBg,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(label, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
