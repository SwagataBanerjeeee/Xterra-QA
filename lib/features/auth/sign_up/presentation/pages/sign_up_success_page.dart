import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:xterra/core/router/app_router.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/step_indicator.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  AppStrings.createAccount,
                  style: AppTextStyles.pageTitle,
                ),
              ),
              SizedBox(height: 16.h),
              StepIndicator(currentStep: 3, totalSteps: 3),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 100.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        AppStrings.accountCreated,
                        style: AppTextStyles.successLabel,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => context.push(AppRouter.register, extra: "HARSH"),
                child: Text("click to check the flow of registor "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
