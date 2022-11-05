import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/ui/dashboard/machines/issues_tab_view.dart';
import 'package:beep/ui/dashboard/machines/review_tab_view.dart';
import 'package:beep/ui/dashboard/machines/stats_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/viewmodel/machine_view_model.dart';
import '../../widget/utility/badge_widget.dart';
import 'assigned_tab_view.dart';
import 'settings_tab_view.dart';

class MachineDetailsView extends StatefulWidget {
  const MachineDetailsView({Key? key}) : super(key: key);

  @override
  State<MachineDetailsView> createState() => _MachineDetailsViewState();
}

class _MachineDetailsViewState extends State<MachineDetailsView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    StatsTabView(),
    ReviewTabView(),
    IssuesTabView(),
    AssignedTabView(),
    SettingsTabView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4.0),
              blurRadius: 12.0,
            )
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black)),
            title: Text(
              machineViewModel.selectedMahcine.machineName.toString(),
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
          ),
        ),
      ),
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
        child: SizedBox(
          // height: 87 + MediaQuery.of(context).viewPadding.bottom,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(
                    'assets/svg/stats-icon.svg',
                    color: _selectedIndex == 0
                        ? const Color(0xff00ab6c)
                        : const Color(0xff898989),
                  ),
                ),
                label: 'Stats',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(
                    'assets/svg/reviews-icon.svg',
                    color: _selectedIndex == 1
                        ? const Color(0xff00ab6c)
                        : const Color(0xff898989),
                  ),
                ),
                label: 'Reviews',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/issues-icon.svg',
                          color: _selectedIndex == 2
                              ? const Color(0xff00ab6c)
                              : const Color(0xff898989),
                        ),
                      ),
                      if (machineViewModel.selectedMahcine.issues !=
                          AppStatus.noIssues)
                        BadgeWidget(
                          count: machineViewModel.selectedMahcine.issues
                              .toString(),
                        )
                    ],
                  ),
                ),
                label: 'Issues',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(
                    'assets/svg/assigned-icon.svg',
                    color: _selectedIndex == 3
                        ? const Color(0xff00ab6c)
                        : const Color(0xff898989),
                  ),
                ),
                label: 'Assigned',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(
                    'assets/svg/settings-icon.svg',
                    color: _selectedIndex == 4
                        ? const Color(0xff00ab6c)
                        : const Color(0xff898989),
                  ),
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff00ab6c),
            unselectedItemColor: const Color(0xff898989),
            onTap: _onItemTapped,
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}
