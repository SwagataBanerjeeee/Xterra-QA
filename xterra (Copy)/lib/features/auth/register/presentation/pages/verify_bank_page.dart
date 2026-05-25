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
import '../providers/register_provider.dart';
import '../widgets/register_header.dart';
import '../widgets/register_bottom_bar.dart';

class VerifyBankPage extends StatefulWidget {
  final String userName;

  const VerifyBankPage({super.key, required this.userName});

  @override
  State<VerifyBankPage> createState() => _VerifyBankPageState();
}

class _VerifyBankPageState extends State<VerifyBankPage> {
  final _holderController = TextEditingController();
  final _bankController = TextEditingController();
  final _ifscController = TextEditingController();
  final _accountController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _holderController.addListener(_validate);
    _bankController.addListener(_validate);
    _ifscController.addListener(_validate);
    _accountController.addListener(_validate);
  }

  void _validate() {
    final digits = _accountController.text.replaceAll(' ', '');
    final valid =
        _holderController.text.trim().isNotEmpty &&
        _bankController.text.trim().isNotEmpty &&
        _ifscController.text.trim().isNotEmpty &&
        digits.length == 16;
    if (valid != _isFormValid) setState(() => _isFormValid = valid);
  }

  Future<void> _handleSubmit() async {
    await context.read<RegisterProvider>().submitBankDetails(
      accountHolderName: _holderController.text.trim(),
      bankName: _bankController.text.trim(),
      ifscCode: _ifscController.text.trim().toUpperCase(),
      accountNumber: _accountController.text.replaceAll(' ', ''),
    );
    if (!mounted) return;
    final provider = context.read<RegisterProvider>();
    if (provider.status == RegisterStatus.success) {
      context.push(AppRouter.registerSuccess);
    } else if (provider.status == RegisterStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    _holderController.dispose();
    _bankController.dispose();
    _ifscController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<RegisterProvider>().isLoading;

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
                    RegisterHeader(userName: widget.userName, currentStep: 3),
                    SizedBox(height: 24.h),
                    Text(
                      AppStrings.verifyBank,
                      style: AppTextStyles.sheetTitle,
                    ),
                    SizedBox(height: 24.h),
                    _FieldLabel(AppStrings.accountHolderName),
                    SizedBox(height: 8.h),
                    _PlainField(
                      controller: _holderController,
                      hint: AppStrings.accountHolderHint,
                    ),
                    SizedBox(height: 20.h),
                    _FieldLabel(AppStrings.bankName),
                    SizedBox(height: 8.h),
                    _PlainField(
                      controller: _bankController,
                      hint: AppStrings.bankNameHint,
                    ),
                    SizedBox(height: 20.h),
                    _FieldLabel(AppStrings.ifscCode),
                    SizedBox(height: 8.h),
                    _PlainField(
                      controller: _ifscController,
                      hint: AppStrings.ifscHint,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    SizedBox(height: 20.h),
                    _FieldLabel(AppStrings.bankAccountNumber),
                    SizedBox(height: 8.h),
                    _AccountNumberField(controller: _accountController),
                  ],
                ),
              ),
            ),
            RegisterBottomBar(
              label: AppStrings.submitForApproval,
              isEnabled: _isFormValid && !isLoading,
              isLoading: isLoading,
              onPressed: _handleSubmit,
              onBack: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Field helpers ──────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.fieldLabel,
        children: [
          TextSpan(text: text),
          const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

class _PlainField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextCapitalization textCapitalization;

  const _PlainField({
    required this.controller,
    required this.hint,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: textCapitalization,
      style: AppTextStyles.fieldText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.fieldHint,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: AppInputDecoration.phoneBorder,
        enabledBorder: AppInputDecoration.phoneBorder,
        focusedBorder: AppInputDecoration.phoneBorder,
      ),
    );
  }
}

class _AccountNumberField extends StatelessWidget {
  final TextEditingController controller;
  const _AccountNumberField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _GroupedDigitsFormatter(groupSize: 4, separator: ' ', maxGroups: 4),
      ],
      style: AppTextStyles.fieldText,
      decoration: InputDecoration(
        hintText: AppStrings.bankAccountHint,
        hintStyle: AppTextStyles.fieldHint,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: AppInputDecoration.phoneBorder,
        enabledBorder: AppInputDecoration.phoneBorder,
        focusedBorder: AppInputDecoration.phoneBorder,
      ),
    );
  }
}

// Formats digits as groups: "1234 5678 9012 3456"
class _GroupedDigitsFormatter extends TextInputFormatter {
  final int groupSize;
  final String separator;
  final int maxGroups;

  const _GroupedDigitsFormatter({
    required this.groupSize,
    required this.separator,
    required this.maxGroups,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(separator, '');
    final maxDigits = groupSize * maxGroups;
    final limited =
        digits.length > maxDigits ? digits.substring(0, maxDigits) : digits;

    final buffer = StringBuffer();
    for (int i = 0; i < limited.length; i++) {
      if (i > 0 && i % groupSize == 0) buffer.write(separator);
      buffer.write(limited[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
