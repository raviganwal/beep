import 'package:beep/ui/dashboard/profile/notification_tab_view.dart';
import 'package:beep/ui/dashboard/profile/school_tab_view.dart';
import 'package:beep/ui/dashboard/profile_tab_view.dart';
import 'package:beep/ui/dashboard/referral_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/referral_view.dart';
import 'machines_tab_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MachinesTabView(),
    SchoolTabView(),
    ReferralTabView(),
    NotificationTabView(),
    ProfileTabView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/svg/machine_tab.svg',
                  color: _selectedIndex == 0
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                ),
              ),
              label: 'Machines',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/svg/school_tab.svg',
                  color: _selectedIndex == 1
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                ),
              ),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/svg/referral_tab_icon.svg',
                  color: _selectedIndex == 2
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                ),
              ),
              label: 'Referral',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/svg/notifications_tab.svg',
                  color: _selectedIndex == 3
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                ),
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  'assets/svg/profile_tab.svg',
                  color: _selectedIndex == 4
                      ? const Color(0xff00ab6c)
                      : const Color(0xff898989),
                ),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff00ab6c),
          unselectedItemColor: const Color(0xff898989),
          onTap: _onItemTapped,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
