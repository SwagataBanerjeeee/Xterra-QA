import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_input_decoration.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/countries.dart';
import '../../../../../core/widgets/country_picker_sheet.dart';
import '../providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const _LoginBody();
}

// ── Body ───────────────────────────────────────────────────────────────────────

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _phoneController = TextEditingController();
  Country _selectedCountry = kDefaultCountry;
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    final digits = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    final valid = digits.length >= _selectedCountry.minLength;
    if (valid != _isPhoneValid) setState(() => _isPhoneValid = valid);
  }

  void _onCountryChanged(Country country) {
    setState(() {
      _selectedCountry = country;
      _phoneController.clear();
      _isPhoneValid = false;
    });
  }

  Future<void> _handleSendOtp() async {
    await context.read<LoginProvider>().sendOtp(
      phone: _phoneController.text,
    );
    if (!mounted) return;
    final provider = context.read<LoginProvider>();
    if (provider.status == LoginStatus.success) {
      context.push(AppRouter.loginOtp);
    } else if (provider.status == LoginStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LoginProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.illustrationBg,
      body: Column(
        children: [
          Expanded(child: _TopSection()),
          _BottomSheet(
            phoneController: _phoneController,
            selectedCountry: _selectedCountry,
            isPhoneValid: _isPhoneValid && !isLoading,
            isLoading: isLoading,
            onCountryChanged: _onCountryChanged,
            onSendOtp: _handleSendOtp,
          ),
        ],
      ),
    );
  }
}

// ── Top gray section ───────────────────────────────────────────────────────────

class _TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Text(AppStrings.logo, style: AppTextStyles.logoTitle),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: SvgPicture.asset(
                AppStrings.houseSearchingsvg,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom white sheet ─────────────────────────────────────────────────────────

class _BottomSheet extends StatelessWidget {
  final TextEditingController phoneController;
  final Country selectedCountry;
  final bool isPhoneValid;
  final bool isLoading;
  final ValueChanged<Country> onCountryChanged;
  final VoidCallback onSendOtp;

  const _BottomSheet({
    required this.phoneController,
    required this.selectedCountry,
    required this.isPhoneValid,
    required this.isLoading,
    required this.onCountryChanged,
    required this.onSendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.logIn, style: AppTextStyles.pageTitle),
              SizedBox(height: 16.h),
              const Divider(color: AppColors.divider, height: 1),
              SizedBox(height: 20.h),
              Text(AppStrings.mobileNumber, style: AppTextStyles.fieldLabel),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CountryCodePicker(
                    country: selectedCountry,
                    onTap: () => CountryPickerSheet.show(
                      context,
                      selected: selectedCountry,
                      onSelected: onCountryChanged,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _PhoneField(
                      controller: phoneController,
                      maxLength: selectedCountry.minLength + 2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _SendOtpButton(
                isEnabled: isPhoneValid,
                isLoading: isLoading,
                onPressed: onSendOtp,
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(AppStrings.or, style: AppTextStyles.orDivider),
              ),
              SizedBox(height: 20.h),
              const _ContinueWithEmailButton(),
              SizedBox(height: 8.h),
            ],
          ),
        ),
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

// ── Phone number field ─────────────────────────────────────────────────────────

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
        child: isLoading
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

// ── Continue with Email button ─────────────────────────────────────────────────

class _ContinueWithEmailButton extends StatelessWidget {
  const _ContinueWithEmailButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          AppStrings.continueWithEmail,
          style: AppTextStyles.buttonLabel,
        ),
      ),
    );
  }
}
