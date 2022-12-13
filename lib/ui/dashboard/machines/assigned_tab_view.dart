import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/assigned_model.dart';
import 'package:beep/core/model/machine_team_model.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widget/utility/no_data_widget.dart';

class AssignedTabView extends StatefulWidget {
  const AssignedTabView({Key? key}) : super(key: key);

  @override
  State<AssignedTabView> createState() => _AssignedTabViewState();
}

class _AssignedTabViewState extends State<AssignedTabView> {
  @override
  void initState() {
    final machineViewModel = context.read<MachineViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      machineViewModel.getMachineTeam();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: ListView.separated(
          itemCount: machineViewModel.machineTeamList.length,
          padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
          itemBuilder: (context, index) {
            TeamMembers model =
                machineViewModel.machineTeamList.elementAt(index);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.firstName} ${model.lastName}",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff00ab6c),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    machineViewModel.getUserRole(
                        role: model.userRole.toString()),
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff898989),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
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
        )

        // SingleChildScrollView(
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        //     alignment: Alignment.center,
        //     height: MediaQuery.of(context).size.height / 1.5,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset('assets/png/no-team-logo.png'),
        //         const SizedBox(
        //           height: 54,
        //         ),
        //         Text(
        //           "You don’t have team member",
        //           textAlign: TextAlign.center,
        //           style: GoogleFonts.nunitoSans(
        //             color: const Color(0xff898989),
        //             fontSize: 17,
        //             fontWeight: FontWeight.w600,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
