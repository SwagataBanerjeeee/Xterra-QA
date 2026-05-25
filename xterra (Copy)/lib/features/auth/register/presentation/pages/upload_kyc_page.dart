import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/picked_file_info.dart';
import '../providers/register_provider.dart';
import '../widgets/register_header.dart';
import '../widgets/register_bottom_bar.dart';

class UploadKycPage extends StatelessWidget {
  final String userName;

  const UploadKycPage({super.key, required this.userName});

  Future<void> _pickFile(
    BuildContext context,
    void Function(PickedFileInfo?) setter,
  ) async {
    final source = await showModalBottomSheet<_PickSource>(
      context: context,
      builder:
          (_) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Photo Library'),
                  onTap: () => Navigator.pop(context, _PickSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  title: const Text('Files / Documents (PDF)'),
                  onTap: () => Navigator.pop(context, _PickSource.files),
                ),
              ],
            ),
          ),
    );
    if (source == null) return;

    final FilePickerResult? result;
    if (source == _PickSource.gallery) {
      result = await FilePicker.platform.pickFiles(type: FileType.image);
    } else {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    }

    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (!context.mounted) return;
    setter(
      PickedFileInfo(
        name: file.name,
        sizeBytes: file.size,
        path: file.path ?? '',
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    await context.read<RegisterProvider>().submitKyc();
    if (!context.mounted) return;
    final provider = context.read<RegisterProvider>();
    if (provider.status == RegisterStatus.success) {
      context.push(AppRouter.registerBank, extra: userName);
    } else if (provider.status == RegisterStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.error ?? 'Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegisterProvider>();
    final canSubmit =
        provider.aadharPanFile != null && provider.gstFile != null;

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
                    RegisterHeader(userName: userName, currentStep: 2),
                    SizedBox(height: 24.h),
                    Text(AppStrings.uploadKyc, style: AppTextStyles.sheetTitle),
                    SizedBox(height: 24.h),
                    _UploadSection(
                      label: AppStrings.aadharPan,
                      file: provider.aadharPanFile,
                      onPick:
                          () => _pickFile(
                            context,
                            context.read<RegisterProvider>().setAadharPanFile,
                          ),
                      onRemove:
                          () => context
                              .read<RegisterProvider>()
                              .setAadharPanFile(null),
                    ),
                    SizedBox(height: 20.h),
                    _UploadSection(
                      label: AppStrings.gstCertificate,
                      file: provider.gstFile,
                      onPick:
                          () => _pickFile(
                            context,
                            context.read<RegisterProvider>().setGstFile,
                          ),
                      onRemove:
                          () =>
                              context.read<RegisterProvider>().setGstFile(null),
                    ),
                  ],
                ),
              ),
            ),
            RegisterBottomBar(
              label: AppStrings.submitKyc,
              isEnabled: canSubmit && !provider.isLoading,
              isLoading: provider.isLoading,
              onPressed: () => _handleSubmit(context),
              onBack: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Upload section ─────────────────────────────────────────────────────────────

class _UploadSection extends StatelessWidget {
  final String label;
  final PickedFileInfo? file;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const _UploadSection({
    required this.label,
    required this.file,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label),
        SizedBox(height: 8.h),
        _UploadBox(onPick: onPick),
        if (file != null) ...[
          SizedBox(height: 8.h),
          _FileTile(file: file!, onRemove: onRemove),
        ],
      ],
    );
  }
}

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

class _UploadBox extends StatelessWidget {
  final VoidCallback onPick;
  const _UploadBox({required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.surfaceLight,
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 32.sp,
              color: AppColors.secondaryText,
            ),
            SizedBox(height: 8.h),
            Text(
              AppStrings.uploadFile,
              style: AppTextStyles.uploadLabel.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 4.h),
            Text(AppStrings.uploadFormats, style: AppTextStyles.uploadFormat),
          ],
        ),
      ),
    );
  }
}

class _FileTile extends StatelessWidget {
  final PickedFileInfo file;
  final VoidCallback onRemove;

  const _FileTile({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.surfaceLight,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/ic_file.svg',
            width: 24.sp,
            height: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: AppTextStyles.fileTileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(file.displaySize, style: AppTextStyles.fileTileSize),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: onRemove,
            child: SvgPicture.asset(
              'assets/images/ic_delete.svg',
              width: 20.sp,
              height: 20.sp,
            ),
          ),
        ],
      ),
    );
  }
}

enum _PickSource { gallery, files }
