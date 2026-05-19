import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_input_decoration.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/countries.dart';
import '../../../../../core/widgets/country_picker_sheet.dart';
import '../providers/sign_up_provider.dart';
import '../../../../../core/widgets/step_indicator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  Country _selectedCountry = kDefaultCountry;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validate);
    _phoneController.addListener(_validate);
  }

  void _validate() {
    final nameOk = _nameController.text.trim().isNotEmpty;
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    final phoneOk = digits.length >= _selectedCountry.minLength;
    final valid = nameOk && phoneOk;
    if (valid != _isFormValid) setState(() => _isFormValid = valid);
  }

  void _onCountryChanged(Country country) {
    setState(() {
      _selectedCountry = country;
      _phoneController.clear();
      _isFormValid = false;
    });
  }

  Future<void> _handleSendOtp() async {
    await context.read<SignUpProvider>().sendOtp(
      name: _nameController.text.trim(),
      phone: _phoneController.text,
    );
    if (!mounted) return;

    final provider = context.read<SignUpProvider>();

    if (provider.status == SignUpStatus.success) {
      context.push(AppRouter.otpVerify, extra: _phoneController.text);
    } else if (provider.status == SignUpStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
                    StepIndicator(currentStep: 1, totalSteps: 3),
                    SizedBox(height: 24.h),
                    Text(
                      AppStrings.verifyMobile,
                      style: AppTextStyles.sheetTitle,
                    ),
                    SizedBox(height: 24.h),
                    Text(AppStrings.fullName, style: AppTextStyles.fieldLabel),
                    SizedBox(height: 8.h),
                    _NameField(controller: _nameController),
                    SizedBox(height: 20.h),
                    Text(
                      AppStrings.mobileNumber,
                      style: AppTextStyles.fieldLabel,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CountryCodePicker(
                          country: _selectedCountry,
                          onTap:
                              () => CountryPickerSheet.show(
                                context,
                                selected: _selectedCountry,
                                onSelected: _onCountryChanged,
                              ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _PhoneField(
                            controller: _phoneController,
                            maxLength: _selectedCountry.minLength + 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
              child: _SendOtpButton(
                isEnabled: _isFormValid && !isLoading,
                isLoading: isLoading,
                onPressed: _handleSendOtp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Name field ─────────────────────────────────────────────────────────────────

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  const _NameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      style: AppTextStyles.fieldText,
      decoration: InputDecoration(
        hintText: AppStrings.fullNameHint,
        hintStyle: AppTextStyles.fieldHint,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: AppInputDecoration.phoneBorder,
        enabledBorder: AppInputDecoration.phoneBorder,
        focusedBorder: AppInputDecoration.phoneBorder,
      ),
    );
  }
}

// ── Country code picker chip ───────────────────────────────────────────────────

class _CountryCodePicker extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const _CountryCodePicker({required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(country.flag, style: AppTextStyles.pickerFlag),
            SizedBox(width: 4.w),
            Text(country.dialCode, style: AppTextStyles.pickerDialCode),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18.sp,
              color: AppColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Phone field ────────────────────────────────────────────────────────────────

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;

  const _PhoneField({required this.controller, required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      style: AppTextStyles.fieldText,
      decoration: InputDecoration(
        hintText: AppStrings.enterPhoneNumber,
        hintStyle: AppTextStyles.fieldHint,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: AppInputDecoration.phoneBorder,
        enabledBorder: AppInputDecoration.phoneBorder,
        focusedBorder: AppInputDecoration.phoneBorder,
        disabledBorder: AppInputDecoration.phoneBorder,
      ),
    );
  }
}

// ── Send OTP button ────────────────────────────────────────────────────────────

class _SendOtpButton extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const _SendOtpButton({
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
        child:
            isLoading
                ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
                : Text(AppStrings.sendOtp, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
