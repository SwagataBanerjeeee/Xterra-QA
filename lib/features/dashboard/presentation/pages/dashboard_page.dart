import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatsGrid(),
          SizedBox(height: 20.h),
          _QuickActions(),
          SizedBox(height: 20.h),
          _BookingTrendCard(),
          SizedBox(height: 20.h),
          _RecentBookings(),
          SizedBox(height: 20.h),
          _RecentActivity(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

}

// ── Stats Grid ────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  static const _stats = [
    _StatData('Total Referrals', '247', '+23 new this week'),
    _StatData('Total Registrations', '105', '+15 this week'),
    _StatData('Total Bookings', '67', '+6 this week'),
    _StatData('Assigned Projects', '11', '+5 from last month'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.55,
      children: _stats.map((s) => _StatCard(data: s)).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              fontSize: 12.sp,
              color: AppColors.secondaryText,
            ),
          ),
          Text(
            data.value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              height: 1.1,
            ),
          ),
          Text(
            data.delta,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  static const _actions = [
    'Create a Referral',
    'Track Buyers',
    'View All Bookings',
    'Download Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 2.4,
          children: _actions.map((label) => _ActionTile(label: label)).toList(),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  const _ActionTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right,
            size: 24.sp,
            color: AppColors.secondaryText,
          ),
        ],
      ),
    );
  }
}

// ── Booking Trend ─────────────────────────────────────────────────────────────

class _BookingTrendCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                Text(
                  'Booking Trend',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                _IconBtn(asset: 'assets/images/ic_download.svg'),
                SizedBox(width: 4.w),
                _IconBtn(asset: 'assets/images/ic_copy.svg'),
              ],
            ),
          ),
          Divider(color: AppColors.divider),
          SizedBox(height: 6.h),
          Container(
            height: 200.h,
            margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 14.h),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.show_chart_rounded,
                    size: 36.sp,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Bookings Chart Placeholder',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.sp,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final String asset;
  const _IconBtn({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Center(child: SvgPicture.asset(asset)),
    );
  }
}

// ── Recent Bookings ───────────────────────────────────────────────────────────

class _RecentBookings extends StatelessWidget {
  static const _items = [
    'John Doe Booked 2bhk in Raj Residency',
    'Sahan Jones booked 3bhk in Skyline Heights',
    'Jack Holland booked 1bhl in Evergreen Residence',
    'John Doe Booked 2bhk in Raj Residency',
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Recent Bookings',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_items.length, (i) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (i > 0)
                  Divider(
                    color: Color(0XFFF5F5F5),
                    height: .2.h,
                    thickness: 1.4.h,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    _items[i],
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      color: Color(0XFF555555),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Recent Activity ───────────────────────────────────────────────────────────

class _RecentActivity extends StatelessWidget {
  static const _items = [
    _ActivityData(
      '1 person registered',
      ' using your referral link',
      '28 May 11:04 am',
    ),
    _ActivityData(
      '2 new projects',
      ' have been assigned to you.',
      '28 May 11:04 am',
    ),
    _ActivityData(
      '1 booking completed',
      ' using your referral link',
      '28 May 11:04 am',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Recent Activity',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_items.length, (i) {
            final item = _items[i];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (i > 0)
                  Divider(
                    color: Color(0XFFF5F5F5),
                    height: .2.h,
                    thickness: 1.4.h,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.sp,
                            color: AppColors.primary,
                          ),
                          children: [
                            TextSpan(
                              text: item.boldPart,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF555555),
                              ),
                            ),
                            TextSpan(
                              text: item.normalPart,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF555555),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.timestamp,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.sp,
                          color: Color(0XFF888888),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Shared section card ───────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  'View All',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.sp,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.divider, height: 1),
          child,
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _StatData {
  final String label, value, delta;
  const _StatData(this.label, this.value, this.delta);
}

class _ActivityData {
  final String boldPart, normalPart, timestamp;
  const _ActivityData(this.boldPart, this.normalPart, this.timestamp);
}
