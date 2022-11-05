import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/core/viewmodel/notifications_view_model.dart';
import 'package:beep/core/viewmodel/team_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodel/auth_view_model.dart';
import 'viewmodel/school_view_model.dart';

///[AppProvider] returns a [MultiProvider] widget that can be used to
///wrap a widget to provide the state through a dependency injection to
///all the child widgets. We wrap the [MaterialApp] with widget to provide
///the state from view models in the whole app.
class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MachineViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TeamViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SchoolViewModel(),
        ),
      ],
      child: child,
    );
  }
}
