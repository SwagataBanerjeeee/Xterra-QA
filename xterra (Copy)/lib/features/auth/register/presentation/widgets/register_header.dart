import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/step_indicator.dart';

class RegisterHeader extends StatelessWidget {
  final String userName;
  final int currentStep;

  const RegisterHeader({
    super.key,
    required this.userName,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.welcomeTitle,
            children: [
              const TextSpan(text: AppStrings.welcomePrefix),
              TextSpan(text: userName),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Text(AppStrings.setupAccount, style: AppTextStyles.welcomeSubtitle, textAlign: TextAlign.center),
        SizedBox(height: 20.h),
        StepIndicator(currentStep: currentStep, totalSteps: 4),
      ],
    );
  }
}
