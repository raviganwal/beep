import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../../core/viewmodel/auth_view_model.dart';
import '../dashboard/dashboard_view.dart';

class StartupView extends StatefulWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authViewModel = context.read<AuthViewModel>();
      await authViewModel.checkLoginAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
