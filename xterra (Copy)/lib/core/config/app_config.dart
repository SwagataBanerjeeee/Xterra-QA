enum Environment { dev, uat, prod }

class AppConfig {
  final String appName;
  final String baseUrl;
  final Environment environment;

  const AppConfig({
    required this.appName,
    required this.baseUrl,
    required this.environment,
  });

  bool get isDev => environment == Environment.dev;
  bool get isUat => environment == Environment.uat;
  bool get isProd => environment == Environment.prod;
}
