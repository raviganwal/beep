import 'package:beep/core/service/api_service.dart';
import 'package:beep/core/service/navigation_service.dart';
import 'package:beep/core/service/shared_pref_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // locator.registerSingleton<SharedPrefService>(SharedPrefService());
  // locator.registerSingleton(PackageInfoService());
  // await locator<PackageInfoService>().getPackageInfo();
  // locator.registerSingleton(LanguageService());
  // await locator<LanguageService>().load();
  // await locator<LanguageService>().loadToc();
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<ApiService>(ApiService());
  locator.registerSingleton<SharedPrefService>(SharedPrefService());
  // locator.registerSingleton(JewishDatesUtil());
  // await locator<JewishDatesUtil>().loadDatesData();
}
