import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<_NotificationItem> _items = [
    _NotificationItem(
      boldTitle: '1 new booking',
      restTitle: ' done in Raheja Arcade',
      body: 'Harsh Mehra booked using your referral link',
      time: '2 hours ago',
      isRead: false,
    ),
    _NotificationItem(
      boldTitle: '1 user registered',
      restTitle: ' using your referral link',
      body: 'Harsh Mehra registered using your referral link',
      time: '6 hours ago',
      isRead: true,
    ),
    _NotificationItem(
      boldTitle: '1 new project',
      restTitle: ' has been assigned to you',
      body: 'Prestige Lakeview Habitat project has been assigned to you.',
      time: '1 day ago',
      isRead: true,
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final item in _items) {
        item.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 18.sp, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _markAllRead,
                child: Text(
                  'Mark All Read',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.sp,
                    color: const Color(0xFF555555),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
              itemCount: _items.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (_, i) => _NotificationCard(item: _items[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItem item;
  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: item.isRead ? const Color(0xFFEEEEEE) : AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              size: 17.sp,
              color: const Color(0xFF555555),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      color: AppColors.primary,
                    ),
                    children: [
                      TextSpan(
                        text: item.boldTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: item.restTitle,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.body,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    color: const Color(0xFF555555),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  item.time,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          if (!item.isRead) ...[
            SizedBox(width: 8.w),
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF9E9E9E),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationItem {
  final String boldTitle;
  final String restTitle;
  final String body;
  final String time;
  bool isRead;

  _NotificationItem({
    required this.boldTitle,
    required this.restTitle,
    required this.body,
    required this.time,
    required this.isRead,
  });
}
