import 'package:beep/core/model/my_team_machine_model.dart';
import 'package:beep/core/model/my_team_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/ui/dashboard/profile/my_team/add_team_member_view.dart';
import 'package:beep/ui/dashboard/profile/my_team/edit_team_member_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_locator.dart';
import '../../../../core/service/navigation_service.dart';
import '../../../widget/button/app_button.dart';
import '../update_password_view.dart';

class MyTeamView extends StatefulWidget {
  const MyTeamView({Key? key}) : super(key: key);

  @override
  State<MyTeamView> createState() => _MyTeamViewState();
}

class _MyTeamViewState extends State<MyTeamView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authViewModel = context.read<AuthViewModel>();
      await authViewModel.getMachineOptions();
      authViewModel.getMyTeam();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 58),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 1.0),
              blurRadius: 1.0,
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
              "My Team",
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(58),
              child: Container(
                height: 58,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Theme(
                  // <- Here
                  data: Theme.of(context).copyWith(
                    // <- Here
                    splashColor: Colors.transparent, // <- Here
                    highlightColor: Colors.transparent, // <- Here
                    hoverColor: Colors.transparent, // <- Here
                  ),
                  child: authViewModel.myTeamMachineList.isEmpty
                      ? const SizedBox()
                      : DropdownButtonHideUnderline(
                          child: DropdownButton<Machines>(
                            value: authViewModel.selectedMachine,
                            icon: SvgPicture.asset(
                                'assets/svg/arrow-down-icon.svg'),
                            elevation: 16,
                            onChanged: (Machines? value) {
                              // This is called when the user selects an item.
                              authViewModel.selectedMachine = value!;
                              authViewModel.getMyTeam(machineId: value.id!);
                            },
                            items: authViewModel.myTeamMachineList
                                .map<DropdownMenuItem<Machines>>(
                                    (Machines value) {
                              return DropdownMenuItem<Machines>(
                                value: value,
                                child: Text(
                                  value.machineName.toString(),
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff212121),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: authViewModel.status == ViewStatus.ready &&
              authViewModel.myTeamList.isEmpty
          ? Container(
              margin: const EdgeInsets.only(bottom: 200),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/png/no-team-logo.png',
                      width: 173,
                      height: 170,
                    ),
                    const SizedBox(
                      height: 54,
                    ),
                    Text(
                      "You don’t have team member",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff898989),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            )
          : ListView.separated(
              itemCount: authViewModel.myTeamList.length,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
              itemBuilder: (context, index) {
                TeamMembers model = authViewModel.myTeamList.elementAt(index);
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${model.firstName} ${model.lastName}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff00ab6c),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await locator<NavigationService>()
                                  .navigateToWidget(
                                      EditTeamMemberView(teamMember: model));
                              authViewModel.getMyTeam();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/edit-member.svg',
                                height: 16,
                                width: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "${authViewModel.getUserRole(role: model.userRole.toString())} - ",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff898989),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${model.machineName}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xFF00AB6C),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xffeaeaea),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/email-icon.svg',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${model.email}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff212121),
                              fontSize: 17,
                              height: 1.52,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/mobile-icon.svg',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${model.phone}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff212121),
                              fontSize: 17,
                              height: 1.52,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset('assets/svg/plus-icon.svg'),
        onPressed: () async {
          await locator<NavigationService>()
              .navigateToWidget(const AddTeamMemberView());
          authViewModel.getMyTeam();
        },
      ),
    );
  }
}
