// Default entry point → dev environment.
// Use main_uat.dart or main_prod.dart for other environments,
// or pass --target lib/main_uat.dart when running flutter run.
import 'bootstrap.dart';
import 'core/config/env/dev_config.dart';

void main() => bootstrap(devConfig);
