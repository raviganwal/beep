import 'package:beep/core/viewmodel/notifications_view_model.dart';
import 'package:beep/ui/dashboard/profile/notifications/messages_view.dart';
import 'package:beep/ui/dashboard/profile/notifications/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodel/auth_view_model.dart';

class NotificationTabView extends StatefulWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Notifications'),
  Tab(text: 'Messages'),
];

class _NotificationTabViewState extends State<NotificationTabView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notificationsViewModel = context.read<NotificationsViewModel>();
      notificationsViewModel.clearNotificationList();
      // notificationsViewModel.getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                bottom: TabBar(
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                  // indicatorWeight: 0,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xff00ab6c), width: 2.0),
                    ),
                  ),
                  labelColor: const Color(0xff00ab6c),
                  labelStyle: GoogleFonts.nunitoSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: GoogleFonts.nunitoSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelColor: const Color(0xff898989),
                  tabs: tabs,
                ),
              ),
            ),
            body: const TabBarView(children: <Widget>[
              NotificationsView(),
              MessagesView(),
            ]));
      }),
    );
  }
}
