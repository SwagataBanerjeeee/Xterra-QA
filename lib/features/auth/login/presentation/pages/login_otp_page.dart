import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_input_decoration.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/router/app_router.dart';
import '../providers/login_provider.dart';

class LoginOtpPage extends StatefulWidget {
  const LoginOtpPage({super.key});

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  static const int _otpLength = 5;

  final _controllers = List.generate(_otpLength, (_) => TextEditingController());
  final _focusNodes  = List.generate(_otpLength, (_) => FocusNode());
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _otpLength; i++) {
      _controllers[i].addListener(_checkComplete);
      final index = i;
      _focusNodes[index].onKeyEvent = (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[index].text.isEmpty &&
            index > 0) {
          _controllers[index - 1].clear();
          _focusNodes[index - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _checkComplete() {
    final complete = _controllers.every((c) => c.text.isNotEmpty);
    if (complete != _isComplete) setState(() => _isComplete = complete);
  }

  void _onChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _handleLogin() async {
    await context.read<LoginProvider>().verifyOtp(otp: _otp);
    if (!mounted) return;
    final provider = context.read<LoginProvider>();
    if (provider.status == LoginStatus.success) {
      context.go(AppRouter.dashboard);
    } else if (provider.status == LoginStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();
    final isLoading = provider.isLoading;
    final phone = provider.phone;

    return Scaffold(
      backgroundColor: AppColors.illustrationBg,
      body: Column(
        children: [
          Expanded(child: _TopSection()),
          _OtpSheet(
            phone: phone,
            controllers: _controllers,
            focusNodes: _focusNodes,
            isComplete: _isComplete,
            isLoading: isLoading,
            onChanged: _onChanged,
            onLogin: _handleLogin,
          ),
        ],
      ),
    );
  }
}

// ── Top gray section (same as LoginPage) ──────────────────────────────────────

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

// ── Bottom OTP sheet ───────────────────────────────────────────────────────────

class _OtpSheet extends StatelessWidget {
  final String phone;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool isComplete;
  final bool isLoading;
  final void Function(int index, String value) onChanged;
  final VoidCallback onLogin;

  const _OtpSheet({
    required this.phone,
    required this.controllers,
    required this.focusNodes,
    required this.isComplete,
    required this.isLoading,
    required this.onChanged,
    required this.onLogin,
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
              _OtpSentRow(phone: phone, onEdit: () => context.pop()),
              SizedBox(height: 16.h),
              _OtpBoxes(
                controllers: controllers,
                focusNodes: focusNodes,
                onChanged: onChanged,
              ),
              SizedBox(height: 12.h),
              Text(
                isComplete ? AppStrings.otpEntered : AppStrings.autoReadingOtp,
                style: AppTextStyles.otpStatus,
              ),
              SizedBox(height: 20.h),
              _LoginButton(
                isEnabled: isComplete && !isLoading,
                isLoading: isLoading,
                onPressed: onLogin,
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ── OTP sent row ───────────────────────────────────────────────────────────────

class _OtpSentRow extends StatelessWidget {
  final String phone;
  final VoidCallback onEdit;

  const _OtpSentRow({required this.phone, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              text: AppStrings.enterOtpPrefix,
              style: AppTextStyles.otpSentText,
              children: [
                TextSpan(
                  text: phone,
                  style: AppTextStyles.otpSentText.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: onEdit,
          child: Icon(
            Icons.edit_outlined,
            size: 16.sp,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}

// ── OTP boxes ─────────────────────────────────────────────────────────────────

class _OtpBoxes extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;

  const _OtpBoxes({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (int i = 0; i < controllers.length; i++) {
      if (i > 0) items.add(SizedBox(width: 8.w));
      items.add(
        Expanded(
          child: _OtpBox(
            controller: controllers[i],
            focusNode: focusNodes[i],
            onChanged: (v) => onChanged(i, v),
          ),
        ),
      );
    }
    return Row(children: items);
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: AppTextStyles.otpDigit,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: AppInputDecoration.phoneBorder,
          enabledBorder: AppInputDecoration.phoneBorder,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// ── Log In button ──────────────────────────────────────────────────────────────

class _LoginButton extends StatelessWidget {
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed;

  const _LoginButton({
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
            : Text(AppStrings.logIn, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
