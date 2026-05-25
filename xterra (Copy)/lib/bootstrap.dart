import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login/presentation/providers/login_provider.dart';
import 'features/auth/sign_up/presentation/providers/sign_up_provider.dart';
import 'features/auth/register/presentation/providers/register_provider.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(config);
  runApp(XterraApp(config: config));
}

class XterraApp extends StatelessWidget {
  final AppConfig config;

  const XterraApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => sl<LoginProvider>(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (_) => sl<SignUpProvider>(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => sl<RegisterProvider>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(402, 874),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp.router(
          title: config.appName,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
