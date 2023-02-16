import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/ui/dashboard/notification_tab_view.dart';
import 'package:beep/ui/dashboard/school_tab_view.dart';
import 'package:beep/ui/dashboard/profile_tab_view.dart';
import 'package:beep/ui/dashboard/referral_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../auth/referral_view.dart';
import 'machines_tab_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.profile();
    });
    super.initState();
  }

  // int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MachinesTabView(),
    SchoolTabView(),
    ReferralTabView(),
    NotificationTabView(),
    ProfileTabView(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Center(
        child: _widgetOptions.elementAt(authViewModel.selectedTabIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(.12),
                blurRadius: 12,
                offset: const Offset(0, -4)),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedLabelStyle: GoogleFonts.nunitoSans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: GoogleFonts.nunitoSans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset(
                  'assets/svg/machine_tab.svg',
                  color: authViewModel.selectedTabIndex == 0
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                  height: 30,
                  width: 30,
                ),
              ),
              label: 'Machines',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset(
                  'assets/svg/school_tab.svg',
                  color: authViewModel.selectedTabIndex == 1
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                  height: 30,
                  width: 30,
                ),
              ),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset(
                  'assets/svg/referral_tab_icon.svg',
                  color: authViewModel.selectedTabIndex == 2
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                  height: 30,
                  width: 30,
                ),
              ),
              label: 'Referral',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset(
                  'assets/svg/notifications_tab.svg',
                  color: authViewModel.selectedTabIndex == 3
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                  height: 30,
                  width: 30,
                ),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SvgPicture.asset(
                  'assets/svg/profile_tab.svg',
                  color: authViewModel.selectedTabIndex == 4
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                  height: 30,
                  width: 30,
                ),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: authViewModel.selectedTabIndex,
          selectedItemColor: const Color(0xff00ab6c),
          unselectedItemColor: const Color(0xff898989),
          onTap: (index) {
            authViewModel.selectedTabIndex = index;
          },
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
