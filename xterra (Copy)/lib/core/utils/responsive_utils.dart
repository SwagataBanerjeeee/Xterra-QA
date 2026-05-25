import 'package:flutter/material.dart';

class ResponsiveUtils {
  static const double _tabletBreakpoint = 600.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= _tabletBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < _tabletBreakpoint;
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  @override
  Widget build(BuildContext context) =>
      ResponsiveUtils.isTablet(context) ? tablet : mobile;
}
