import 'package:beep/ui/auth/login_view.dart';
import 'package:flutter/material.dart';

import 'core/app_locator.dart';
import 'core/app_provider.dart';
import 'core/app_theme.dart';
import 'core/service/navigation_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Beep',
        theme: appTheme,
        navigatorKey: locator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}

