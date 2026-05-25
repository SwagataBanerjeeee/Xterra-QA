import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_input_decoration.dart';
import '../theme/app_text_styles.dart';
import '../utils/countries.dart';

class CountryPickerSheet extends StatefulWidget {
  final Country selected;
  final ValueChanged<Country> onSelected;

  const CountryPickerSheet({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required Country selected,
    required ValueChanged<Country> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CountryPickerSheet(
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  final _searchController = TextEditingController();
  List<Country> _filtered = kCountries;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchController.text.toLowerCase().trim();
    setState(() {
      _filtered = q.isEmpty
          ? kCountries
          : kCountries
              .where(
                (c) =>
                    c.name.toLowerCase().contains(q) ||
                    c.dialCode.contains(q) ||
                    c.code.toLowerCase().contains(q),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _DragHandle(),
          _Header(onClose: () => Navigator.pop(context)),
          SizedBox(height: 12.h),
          _SearchField(controller: _searchController),
          SizedBox(height: 4.h),
          Expanded(
            child: _filtered.isEmpty
                ? _EmptyState()
                : _CountryList(
                    countries: _filtered,
                    selected: widget.selected,
                    onTap: (country) {
                      widget.onSelected(country);
                      Navigator.pop(context);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, bottom: 4.h),
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.dragHandle,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onClose;
  const _Header({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.selectCountry, style: AppTextStyles.sheetTitle),
          GestureDetector(
            onTap: onClose,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 18.sp,
                color: AppColors.iconSubdued,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: controller,
        style: AppTextStyles.searchText,
        decoration: AppInputDecoration.countrySearch,
      ),
    );
  }
}

class _CountryList extends StatelessWidget {
  final List<Country> countries;
  final Country selected;
  final ValueChanged<Country> onTap;

  const _CountryList({
    required this.countries,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: countries.length,
      separatorBuilder: (_, _) => SizedBox(height: 2.h),
      itemBuilder: (context, index) {
        final country = countries[index];
        final isSelected = country.code == selected.code;
        return _CountryTile(
          country: country,
          isSelected: isSelected,
          onTap: () => onTap(country),
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  final Country country;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountryTile({
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.surfaceLight : Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              Text(country.flag, style: AppTextStyles.listFlag),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  country.name,
                  style: AppTextStyles.countryName(selected: isSelected),
                ),
              ),
              Text(country.dialCode, style: AppTextStyles.countryDialCode),
              SizedBox(width: 8.w),
              SizedBox(
                width: 20.w,
                child: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        size: 20.sp,
                        color: AppColors.primary,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.sp,
            color: AppColors.dragHandle,
          ),
          SizedBox(height: 12.h),
          Text(AppStrings.noCountryFound, style: AppTextStyles.emptyStateLabel),
        ],
      ),
    );
  }
}
