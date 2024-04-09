import 'package:get_it/get_it.dart';

import 'core/preferences/preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

setupLocators() async {
  //
  sl.registerLazySingleton<http.Client>(() => http.Client());

  sl.registerSingleton<Preferences>(Preferences.instance);

  // login Injection Container
  // LoginInjectionContainer().register();
}
