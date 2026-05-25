import 'package:get_it/get_it.dart';
import '../config/app_config.dart';
import '../network/dio_client.dart';
import '../storage/hive_service.dart';

// ── Login ─────────────────────────────────────────────────────────────────────
import '../../features/auth/login/data/datasources/login_remote_datasource.dart';
import '../../features/auth/login/data/repositories/login_repository_impl.dart';
import '../../features/auth/login/domain/repositories/login_repository.dart';
import '../../features/auth/login/domain/usecases/login_usecase.dart';
import '../../features/auth/login/domain/usecases/logout_usecase.dart';
import '../../features/auth/login/domain/usecases/send_login_otp_usecase.dart';
import '../../features/auth/login/domain/usecases/verify_login_otp_usecase.dart';
import '../../features/auth/login/presentation/providers/login_provider.dart';

// ── Sign Up ───────────────────────────────────────────────────────────────────
import '../../features/auth/sign_up/data/datasources/sign_up_remote_datasource.dart';
import '../../features/auth/sign_up/data/repositories/sign_up_repository_impl.dart';
import '../../features/auth/sign_up/domain/repositories/sign_up_repository.dart';
import '../../features/auth/sign_up/domain/usecases/create_account_usecase.dart';
import '../../features/auth/sign_up/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/sign_up/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/sign_up/presentation/providers/sign_up_provider.dart';

// ── Register ──────────────────────────────────────────────────────────────────
import '../../features/auth/register/data/datasources/register_remote_datasource.dart';
import '../../features/auth/register/data/repositories/register_repository_impl.dart';
import '../../features/auth/register/domain/repositories/register_repository.dart';
import '../../features/auth/register/domain/usecases/submit_details_usecase.dart';
import '../../features/auth/register/domain/usecases/submit_kyc_usecase.dart';
import '../../features/auth/register/domain/usecases/submit_bank_usecase.dart';
import '../../features/auth/register/presentation/providers/register_provider.dart';

final sl = GetIt.instance;

Future<void> configureDependencies(AppConfig config) async {
  // ── Core ──────────────────────────────────────────────────────
  sl.registerSingleton<AppConfig>(config);

  final hive = HiveService();
  await hive.init();
  sl.registerSingleton<HiveService>(hive);

  sl.registerSingleton<DioClient>(
    DioClient(config: sl(), hiveService: sl()),
  );

  // ── Login: data sources ───────────────────────────────────────
  sl.registerLazySingleton<LoginRemoteDatasource>(
    () => LoginRemoteDatasourceImpl(dio: sl<DioClient>().dio),
  );

  // ── Login: repositories ───────────────────────────────────────
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDatasource: sl(), hiveService: sl()),
  );

  // ── Login: use cases ──────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => SendLoginOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyLoginOtpUsecase(repository: sl()));

  // ── Login: provider (singleton — persists across multi-step OTP flow) ────
  sl.registerLazySingleton(
    () => LoginProvider(
      loginUsecase: sl(),
      logoutUsecase: sl(),
      sendLoginOtpUsecase: sl(),
      verifyLoginOtpUsecase: sl(),
    ),
  );

  // ── Sign Up: data sources ─────────────────────────────────────
  sl.registerLazySingleton<SignUpRemoteDatasource>(
    () => SignUpRemoteDatasourceImpl(dio: sl<DioClient>().dio),
  );

  // ── Sign Up: repositories ─────────────────────────────────────
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(remoteDatasource: sl()),
  );

  // ── Sign Up: use cases ────────────────────────────────────────
  sl.registerLazySingleton(() => SendOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateAccountUsecase(repository: sl()));

  // ── Sign Up: provider (singleton — persists across multi-step flow) ────────
  sl.registerLazySingleton(
    () => SignUpProvider(
      sendOtpUsecase: sl(),
      verifyOtpUsecase: sl(),
      createAccountUsecase: sl(),
    ),
  );

  // ── Register: data sources ────────────────────────────────────────────────
  sl.registerLazySingleton<RegisterRemoteDatasource>(
    () => RegisterRemoteDatasourceImpl(dio: sl<DioClient>().dio),
  );

  // ── Register: repositories ────────────────────────────────────────────────
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(remoteDatasource: sl()),
  );

  // ── Register: use cases ───────────────────────────────────────────────────
  sl.registerLazySingleton(() => SubmitDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubmitKycUsecase(repository: sl()));
  sl.registerLazySingleton(() => SubmitBankUsecase(repository: sl()));

  // ── Register: provider (singleton — persists across multi-step flow) ──────
  sl.registerLazySingleton(
    () => RegisterProvider(
      submitDetailsUsecase: sl(),
      submitKycUsecase: sl(),
      submitBankUsecase: sl(),
    ),
  );
}
