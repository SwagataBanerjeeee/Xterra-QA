import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class MyProjectsBody extends StatefulWidget {
  const MyProjectsBody({super.key});

  @override
  State<MyProjectsBody> createState() => _MyProjectsBodyState();
}

class _MyProjectsBodyState extends State<MyProjectsBody> {
  final _searchCtrl = TextEditingController();
  String _activeFilter = '';

  static const _filterChips = [
    _FilterChip('Sort', true),
    _FilterChip('Filters', true),
    _FilterChip('Residential', false),
    _FilterChip('Commercial', false),
    _FilterChip('Reset', false),
  ];

  static const _projects = [
    _ProjectData(
      name: 'Raj Residency',
      location: 'Pune, Maharashtra',
      units: '24 Units Available',
      image: 'assets/images/projects/project_1.png',
      propertyType: 'Residential',
      assignedSince: '12 Jan 2024',
      commission: '2.5%',
    ),
    _ProjectData(
      name: 'Skyline Heights',
      location: 'Mumbai, Maharashtra',
      units: '12 Units Available',
      image: 'assets/images/projects/project_2.png',
      propertyType: 'Commercial',
      assignedSince: '05 Mar 2024',
      commission: '3.0%',
    ),
    _ProjectData(
      name: 'Evergreen Residency',
      location: 'Nashik, Maharashtra',
      units: '36 Units Available',
      image: 'assets/images/projects/project_3.png',
      propertyType: 'Residential',
      assignedSince: '20 Feb 2024',
      commission: '2.0%',
    ),
    _ProjectData(
      name: 'The Green Valley',
      location: 'Lonavala, Maharashtra',
      units: '8 Units Available',
      image: 'assets/images/projects/project_4.png',
      propertyType: 'Residential',
      assignedSince: '01 Apr 2024',
      commission: '2.75%',
    ),
    _ProjectData(
      name: 'City Square Tower',
      location: 'Pune, Maharashtra',
      units: '50 Units Available',
      image: 'assets/images/projects/project_6.png',
      propertyType: 'Commercial',
      assignedSince: '15 Nov 2023',
      commission: '3.5%',
    ),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchAndFilters(),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            itemCount: _projects.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (_, i) => _ProjectCard(data: _projects[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      child: Column(
        children: [
          // Search bar
          Container(
            height: 44.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Row(
              children: [
                SizedBox(width: 12.w),
                Icon(Icons.search, size: 20.sp, color: const Color(0xFF888888)),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.sp,
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search by Project Name',
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.sp,
                        color: const Color(0xFF888888),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Icon(Icons.mic_none, size: 20.sp, color: const Color(0xFF888888)),
                SizedBox(width: 12.w),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          // Filter chips
          SizedBox(
            height: 32.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filterChips.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (_, i) {
                final chip = _filterChips[i];
                final isActive = _activeFilter == chip.label;
                return GestureDetector(
                  onTap: () => setState(
                    () => _activeFilter = isActive ? '' : chip.label,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primary
                            : const Color(0xFFD9D9D9),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          chip.label,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isActive
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        ),
                        if (chip.hasArrow) ...[
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 14.sp,
                            color: isActive
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}

// ── Project Card ─────────────────────────────────────────────────────────────

class _ProjectCard extends StatelessWidget {
  final _ProjectData data;
  const _ProjectCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.projectDetail),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      data.image,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 80.w,
                        height: 80.w,
                        color: const Color(0xFFE5E5E5),
                        child: Icon(
                          Icons.apartment,
                          size: 32.sp,
                          color: const Color(0xFF888888),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Project info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                data.name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            // Share button
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE5E5E5),
                                ),
                              ),
                              child: Icon(
                                Icons.share_outlined,
                                size: 16.sp,
                                color: const Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        // Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 13.sp,
                              color: const Color(0xFF888888),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                data.location,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  color: const Color(0xFF888888),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        // Units available
                        Row(
                          children: [
                            Icon(
                              Icons.apartment_outlined,
                              size: 13.sp,
                              color: const Color(0xFF888888),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              data.units,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.sp,
                                color: const Color(0xFF888888),
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
            // Divider
            Divider(height: 1, thickness: 1, color: const Color(0xFFEEEEEE)),
            // Bottom stats row
            IntrinsicHeight(
              child: Row(
                children: [
                  _StatCell(
                    label: 'Property type',
                    value: data.propertyType,
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: const Color(0xFFEEEEEE),
                  ),
                  _StatCell(
                    label: 'Assigned Since',
                    value: data.assignedSince,
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: const Color(0xFFEEEEEE),
                  ),
                  _StatCell(
                    label: 'Commission',
                    value: data.commission,
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

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  const _StatCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10.sp,
                color: const Color(0xFF888888),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _FilterChip {
  final String label;
  final bool hasArrow;
  const _FilterChip(this.label, this.hasArrow);
}

class _ProjectData {
  final String name;
  final String location;
  final String units;
  final String image;
  final String propertyType;
  final String assignedSince;
  final String commission;

  const _ProjectData({
    required this.name,
    required this.location,
    required this.units,
    required this.image,
    required this.propertyType,
    required this.assignedSince,
    required this.commission,
  });
}

