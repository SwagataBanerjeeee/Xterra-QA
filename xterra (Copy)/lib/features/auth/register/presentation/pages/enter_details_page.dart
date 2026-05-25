import 'package:flutter/material.dart';
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

class EnterDetailsPage extends StatefulWidget {
  final String userName;

  const EnterDetailsPage({super.key, required this.userName});

  @override
  State<EnterDetailsPage> createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  final _orgNameController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _orgNameController.text = 'propertyhub';
    _addressController.addListener(_validate);
  }

  void _validate() {
    final valid = _addressController.text.trim().isNotEmpty;
    if (valid != _isFormValid) setState(() => _isFormValid = valid);
  }

  Future<void> _handleSubmit() async {
    await context.read<RegisterProvider>().submitDetails(
      orgName: _orgNameController.text.trim(),
      address: _addressController.text.trim(),
    );
    if (!mounted) return;
    final provider = context.read<RegisterProvider>();
    if (provider.status == RegisterStatus.success) {
      context.push(AppRouter.registerKyc, extra: widget.userName);
    } else if (provider.status == RegisterStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  void dispose() {
    _orgNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<RegisterProvider>().isLoading;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegisterHeader(userName: widget.userName, currentStep: 1),
                    SizedBox(height: 24.h),
                    Text(
                      AppStrings.enterDetails,
                      style: AppTextStyles.sheetTitle,
                    ),
                    SizedBox(height: 24.h),
                    _FieldLabel(AppStrings.orgName, required: true),
                    SizedBox(height: 8.h),
                    _TextField(
                      controller: _orgNameController,
                      hint: AppStrings.orgNameHint,
                      enabled: false,
                    ),
                    SizedBox(height: 20.h),
                    _FieldLabel(AppStrings.address, required: false),
                    SizedBox(height: 8.h),
                    _TextField(
                      controller: _addressController,
                      hint: AppStrings.addressHint,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            RegisterBottomBar(
              label: AppStrings.submitDetails,
              isEnabled: _isFormValid && !isLoading,
              isLoading: isLoading,
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  const _FieldLabel(this.text, {required this.required});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.fieldLabel,
        children: [
          TextSpan(text: text),
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final bool enabled;

  const _TextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      enabled: enabled,
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
