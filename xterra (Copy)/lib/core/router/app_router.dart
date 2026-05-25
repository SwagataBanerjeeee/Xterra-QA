import 'package:go_router/go_router.dart';
import '../../features/auth/login/presentation/pages/login_page.dart';
import '../../features/auth/sign_up/presentation/pages/get_started_page.dart';
import '../../features/auth/sign_up/presentation/pages/otp_verify_page.dart';
import '../../features/auth/sign_up/presentation/pages/set_password_page.dart';
import '../../features/auth/sign_up/presentation/pages/sign_up_page.dart';
import '../../features/auth/sign_up/presentation/pages/sign_up_success_page.dart';
import '../../features/auth/login/presentation/pages/login_otp_page.dart';
import '../../features/auth/register/presentation/pages/enter_details_page.dart';
import '../../features/auth/register/presentation/pages/upload_kyc_page.dart';
import '../../features/auth/register/presentation/pages/verify_bank_page.dart';
import '../../features/auth/register/presentation/pages/register_success_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/profile_settings_page.dart';
import '../../features/projects/presentation/pages/project_detail_page.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';

class AppRouter {
  static const String getStarted      = '/';
  static const String signUp          = '/sign-up';
  static const String otpVerify       = '/sign-up/otp';
  static const String setPassword     = '/sign-up/password';
  static const String signUpSuccess   = '/sign-up/success';
  static const String login           = '/login';
  static const String loginOtp        = '/login/otp';
  static const String register        = '/register';
  static const String registerKyc     = '/register/kyc';
  static const String registerBank    = '/register/bank';
  static const String registerSuccess = '/register/success';
  static const String dashboard       = '/dashboard';
  static const String myProjects      = '/my-projects';
  static const String leads           = '/leads';
  static const String performance     = '/performance';
  static const String logs            = '/logs';
  static const String notifications   = '/notifications';
  static const String profileSettings = '/profile-settings';
  static const String projectDetail   = '/project-detail';

  static final router = GoRouter(
    initialLocation: getStarted,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: getStarted,
        name: 'get-started',
        builder: (context, state) => const GetStartedPage(),
      ),
      GoRoute(
        path: signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: otpVerify,
        name: 'otp-verify',
        builder: (context, state) => OtpVerifyPage(
          phone: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: setPassword,
        name: 'set-password',
        builder: (context, state) => const SetPasswordPage(),
      ),
      GoRoute(
        path: signUpSuccess,
        name: 'sign-up-success',
        builder: (context, state) => const SignUpSuccessPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: loginOtp,
        name: 'login-otp',
        builder: (context, state) => const LoginOtpPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => EnterDetailsPage(
          userName: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: registerKyc,
        name: 'register-kyc',
        builder: (context, state) => UploadKycPage(
          userName: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: registerBank,
        name: 'register-bank',
        builder: (context, state) => VerifyBankPage(
          userName: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: registerSuccess,
        name: 'register-success',
        builder: (context, state) => RegisterSuccessPage(
          userName: state.extra as String? ?? '',
        ),
      ),
      // ── Shell routes (persistent bottom nav) ─────────────────────────────
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        builder: (context, state) => const MainShellPage(initialTab: 0),
      ),
      GoRoute(
        path: myProjects,
        name: 'my-projects',
        builder: (context, state) => const MainShellPage(initialTab: 1),
      ),
      GoRoute(
        path: leads,
        name: 'leads',
        builder: (context, state) => const MainShellPage(initialTab: 2),
      ),
      GoRoute(
        path: performance,
        name: 'performance',
        builder: (context, state) => const MainShellPage(initialTab: 3),
      ),
      GoRoute(
        path: logs,
        name: 'logs',
        builder: (context, state) => const MainShellPage(initialTab: 4),
      ),
      // ── Overlay routes (pushed on top of shell) ───────────────────────────
      GoRoute(
        path: notifications,
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: profileSettings,
        name: 'profile-settings',
        builder: (context, state) => const ProfileSettingsPage(),
      ),
      GoRoute(
        path: projectDetail,
        name: 'project-detail',
        builder: (context, state) => const ProjectDetailPage(),
      ),
    ],
  );
}
