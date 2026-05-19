import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../projects/presentation/pages/my_projects_page.dart';

class MainShellPage extends StatefulWidget {
  final int initialTab;
  const MainShellPage({this.initialTab = 0, super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  late int _currentTab;

  static const _titles = [
    'Channel Partner Portal',
    'My Projects',
    'Leads',
    'Performance',
    'Logs',
  ];

  static const _tabs = [
    _NavTab(asset: 'assets/images/ic_dashboard.svg', label: 'Dashboard'),
    _NavTab(asset: 'assets/images/ic_my_projects.svg', label: 'My Projects'),
    _NavTab(asset: 'assets/images/ic_leads.svg', label: 'Leads'),
    _NavTab(asset: 'assets/images/ic_performance.svg', label: 'Performance'),
    _NavTab(icon: Icons.receipt_long_outlined, label: 'Logs'),
  ];

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: _buildAppBar(context),
      body: IndexedStack(
        index: _currentTab,
        children: const [
          DashboardBody(),
          MyProjectsBody(),
          _LeadsBody(),
          _PerformanceBody(),
          _LogsBody(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16.w,
      title: Text(
        _titles[_currentTab],
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: _currentTab == 0 ? Color(0XFF333333) : AppColors.primary,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 4.w),
          decoration: const BoxDecoration(
            color: Color(0xFFEAEAEA),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 22.sp,
              color: AppColors.primary,
            ),
            onPressed: () => context.push(AppRouter.notifications),
          ),
        ),
        SizedBox(width: 4.w),
        Container(
          margin: EdgeInsets.only(right: 16.w),
          decoration: const BoxDecoration(
            color: Color(0xFFEAEAEA),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.menu, size: 22.sp, color: AppColors.primary),
            onPressed: () => context.push(AppRouter.profileSettings),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60.h,
          child: Row(
            children: List.generate(_tabs.length, (i) {
              final selected = i == _currentTab;
              final tab = _tabs[i];
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _currentTab = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (tab.asset != null)
                        SvgPicture.asset(
                          tab.asset!,
                          width: 22.sp,
                          height: 22.sp,
                          colorFilter: ColorFilter.mode(
                            selected ? Color(0XFF333333) : Color(0XFFAAAAAA),
                            BlendMode.srcIn,
                          ),
                        )
                      else
                        Icon(
                          tab.icon!,
                          size: 22.sp,
                          color:
                              selected ? Color(0XFF333333) : Color(0XFFAAAAAA),
                        ),
                      SizedBox(height: 2.h),
                      Text(
                        tab.label,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.sp,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.normal,
                          color:
                              selected ? Color(0XFF333333) : Color(0XFFAAAAAA),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Placeholder bodies ────────────────────────────────────────────────────────

class _LeadsBody extends StatelessWidget {
  const _LeadsBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_outline,
            size: 64.sp,
            color: const Color(0xFFCCCCCC),
          ),
          SizedBox(height: 16.h),
          Text(
            'Leads',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Coming soon',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceBody extends StatelessWidget {
  const _PerformanceBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bar_chart_outlined,
            size: 64.sp,
            color: const Color(0xFFCCCCCC),
          ),
          SizedBox(height: 16.h),
          Text(
            'Performance',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Coming soon',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogsBody extends StatelessWidget {
  const _LogsBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64.sp,
            color: const Color(0xFFCCCCCC),
          ),
          SizedBox(height: 16.h),
          Text(
            'Logs',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Coming soon',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Nav model ─────────────────────────────────────────────────────────────────

class _NavTab {
  final IconData? icon;
  final String? asset;
  final String label;
  const _NavTab({this.icon, this.asset, required this.label});
}
