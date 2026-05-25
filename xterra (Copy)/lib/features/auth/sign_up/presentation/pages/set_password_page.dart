import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_input_decoration.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../providers/sign_up_provider.dart';
import '../../../../../core/widgets/step_indicator.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final _passwordController = TextEditingController();
  bool _termsAccepted = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validate);
  }

  void _validate() {
    final valid = _passwordController.text.isNotEmpty && _termsAccepted;
    if (valid != _isFormValid) setState(() => _isFormValid = valid);
  }

  void _onTermsChanged(bool? value) {
    setState(() {
      _termsAccepted = value ?? false;
      _validate();
    });
  }

  Future<void> _handleCreateAccount() async {
    await context.read<SignUpProvider>().createAccount(
      password: _passwordController.text,
    );
    if (!mounted) return;
    final provider = context.read<SignUpProvider>();
    if (provider.status == SignUpStatus.success) {
      context.push(AppRouter.signUpSuccess);
    } else if (provider.status == SignUpStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<SignUpProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                    StepIndicator(currentStep: 2, totalSteps: 3),
                    SizedBox(height: 24.h),
                    Text(AppStrings.setPassword, style: AppTextStyles.sheetTitle),
                    SizedBox(height: 24.h),
                    Text(AppStrings.password, style: AppTextStyles.fieldLabel),
                    SizedBox(height: 8.h),
                    _PasswordField(controller: _passwordController),
                  ],
                ),
              ),
            ),
            const Divider(color: AppColors.divider, height: 1),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TermsRow(
                    accepted: _termsAccepted,
                    onChanged: _onTermsChanged,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _BackButton(onPressed: () => context.pop()),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        flex: 2,
                        child: _PrimaryButton(
                          label: AppStrings.createAccount,
                          isEnabled: _isFormValid && !isLoading,
                          isLoading: isLoading,
                          onPressed: _handleCreateAccount,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Password field ─────────────────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: AppTextStyles.fieldText,
      decoration: InputDecoration(
        hintText: AppStrings.passwordHint,
        hintStyle: AppTextStyles.fieldHint,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: AppInputDecoration.phoneBorder,
        enabledBorder: AppInputDecoration.phoneBorder,
        focusedBorder: AppInputDecoration.phoneBorder,
      ),
    );
  }
}

// ── Terms row ──────────────────────────────────────────────────────────────────

class _TermsRow extends StatelessWidget {
  final bool accepted;
  final ValueChanged<bool?> onChanged;

  const _TermsRow({required this.accepted, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.w,
          child: Checkbox(
            value: accepted,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.termsText,
              children: [
                TextSpan(text: AppStrings.termsPart1),
                TextSpan(
                  text: AppStrings.termsOfService,
                  style: AppTextStyles.termsLink,
                ),
                TextSpan(text: AppStrings.termsPart2),
                TextSpan(
                  text: AppStrings.privacyPolicy,
                  style: AppTextStyles.termsLink,
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Buttons ────────────────────────────────────────────────────────────────────

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
        child: Text(AppStrings.back, style: AppTextStyles.buttonLabel),
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
