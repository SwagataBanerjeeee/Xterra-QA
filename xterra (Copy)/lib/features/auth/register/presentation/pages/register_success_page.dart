import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/step_indicator.dart';

class RegisterSuccessPage extends StatelessWidget {
  final String userName;

  const RegisterSuccessPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
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
              Text(
                AppStrings.setupAccount,
                style: AppTextStyles.welcomeSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              StepIndicator(currentStep: 4, totalSteps: 4),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 80.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppStrings.submittedTitle,
                        style: AppTextStyles.successTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        AppStrings.submittedSubtitle,
                        style: AppTextStyles.successSubtitle,
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () => context.push("/login"),
                        child: Text("click to see the login flow"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
