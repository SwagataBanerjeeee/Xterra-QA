import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $currentStep of $totalSteps',
          style: AppTextStyles.fieldLabel,
        ),
        SizedBox(height: 8.h),
        Row(
          children: List.generate(totalSteps, (index) {
            final filled = index < currentStep;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: index < totalSteps - 1 ? 6.w : 0,
                ),
                height: 4.h,
                decoration: BoxDecoration(
                  color: filled ? AppColors.primary : AppColors.divider,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
