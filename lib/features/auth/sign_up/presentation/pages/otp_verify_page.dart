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
import '../providers/sign_up_provider.dart';
import '../../../../../core/widgets/step_indicator.dart';

class OtpVerifyPage extends StatefulWidget {
  final String phone;

  const OtpVerifyPage({super.key, required this.phone});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
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

  Future<void> _handleVerifyOtp() async {
    await context.read<SignUpProvider>().verifyOtp(otp: _otp);
    if (!mounted) return;
    final provider = context.read<SignUpProvider>();
    if (provider.status == SignUpStatus.success) {
      context.push(AppRouter.setPassword);
    } else if (provider.status == SignUpStatus.failure) {
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
                    Text(AppStrings.verifyMobile, style: AppTextStyles.sheetTitle),
                    SizedBox(height: 16.h),
                    _OtpSentRow(
                      phone: widget.phone,
                      onEdit: () => context.pop(),
                    ),
                    SizedBox(height: 16.h),
                    _OtpBoxes(
                      controllers: _controllers,
                      focusNodes: _focusNodes,
                      onChanged: _onChanged,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      _isComplete
                          ? AppStrings.otpEntered
                          : AppStrings.autoReadingOtp,
                      style: AppTextStyles.otpStatus,
                    ),
                  ],
                ),
              ),
            ),
            const _BottomDivider(),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _BackButton(onPressed: () => context.pop()),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: _PrimaryButton(
                      label: AppStrings.verifyOtp,
                      isEnabled: _isComplete && !isLoading,
                      isLoading: isLoading,
                      onPressed: _handleVerifyOtp,
                    ),
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

// ── OTP sent info row ──────────────────────────────────────────────────────────

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

// ── Shared bottom widgets ──────────────────────────────────────────────────────

class _BottomDivider extends StatelessWidget {
  const _BottomDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(color: AppColors.divider, height: 1);
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
