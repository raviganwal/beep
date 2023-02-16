import 'package:beep/core/model/earnings_model.dart';
import 'package:beep/core/model/my_team_machine_model.dart';
import 'package:beep/core/model/my_team_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/ui/dashboard/profile/my_team/add_team_member_view.dart';
import 'package:beep/ui/dashboard/profile/my_team/edit_team_member_view.dart';
import 'package:beep/ui/widget/button/white_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_locator.dart';
import '../../../../core/service/navigation_service.dart';
import '../../../widget/button/app_button.dart';
import '../update_password_view.dart';
import 'package:beep/core/date_extension.dart';

class EarningsView extends StatefulWidget {
  const EarningsView({Key? key}) : super(key: key);

  @override
  State<EarningsView> createState() => _EarningsViewState();
}

class _EarningsViewState extends State<EarningsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authViewModel = context.read<AuthViewModel>();
      await authViewModel.getEarnings();
      await authViewModel.getMachineOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
              'Earnings',
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {
                  inputCodeModal();
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Withdraw",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (authViewModel.profileModel != null)
              Container(
                margin: const EdgeInsets.only(top: 18, bottom: 3),
                child: Text(
                  "${authViewModel.profileModel?.totalEarnings}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff00ab6c),
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            Text(
              "Total Earnings",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff898989),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 1,
            //   color: const Color(0xffeaeaea),
            //   margin: const EdgeInsets.only(top: 13),
            // ),
            // Container(
            //     height: 58,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.white,
            //     padding: const EdgeInsets.symmetric(horizontal: 24),
            //     child: Theme(
            //       // <- Here
            //       data: Theme.of(context).copyWith(
            //         // <- Here
            //         splashColor: Colors.transparent, // <- Here
            //         highlightColor: Colors.transparent, // <- Here
            //         hoverColor: Colors.transparent, // <- Here
            //       ),
            //       child: authViewModel.myTeamMachineList.isEmpty
            //           ? const SizedBox()
            //           : DropdownButtonHideUnderline(
            //               child: DropdownButton<Machines>(
            //                 value: authViewModel.selectedMachine,
            //                 icon: SvgPicture.asset(
            //                     'assets/svg/arrow-down-icon.svg'),
            //                 elevation: 16,
            //                 onChanged: (Machines? value) {
            //                   // This is called when the user selects an item.
            //                   authViewModel.selectedMachine = value!;
            //                   authViewModel.getMyTeam(machineId: value.id!);
            //                 },
            //                 items: authViewModel.myTeamMachineList
            //                     .map<DropdownMenuItem<Machines>>(
            //                         (Machines value) {
            //                   return DropdownMenuItem<Machines>(
            //                     value: value,
            //                     child: Text(
            //                       value.machineName.toString(),
            //                       style: GoogleFonts.nunitoSans(
            //                         color: const Color(0xff212121),
            //                       ),
            //                     ),
            //                   );
            //                 }).toList(),
            //               ),
            //             ),
            //     )),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 24),
            //   width: double.infinity,
            //   height: 1,
            //   color: const Color(0xffeaeaea),
            // ),
            ListView.separated(
              itemCount:
                  authViewModel.earningsModel?.paymentHistory?.length ?? 0,
              padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                PaymentHistory model = authViewModel
                    .earningsModel!.paymentHistory!
                    .elementAt(index);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: model.type?.toLowerCase() == 'income'
                            ? const Color(0xff00ab6c)
                            : const Color(0xff0cc1eb),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (model.datetime != null)
                          Text(
                            model.datetime!.toyyyyMMddParse.toEEEMMMddhhmma
                                .toString(),
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff898989),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        const SizedBox(height: 3),
                        Text(
                          "${model.amount}",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (model.machine != null)
                          Text(
                            "${model.machine}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff212121),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                      ],
                    ),
                    const Spacer(),
                    model.type == "Income"
                        ? Column(
                            children: [
                              SvgPicture.asset('assets/svg/down_icon.svg'),
                              Text(
                                "Income",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff00ab6c),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SvgPicture.asset('assets/svg/up_icon.svg'),
                              Text(
                                "Withdraw",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff0cc1eb),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  inputCodeModal() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        final authViewModel = context.watch<AuthViewModel>();
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
                child: Row(
                  children: [
                    Text(
                      "Withdraw",
                      style: GoogleFonts.nunitoSans(
                        color: Color(0xff212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close)),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Image.asset(
                "assets/png/dollar_img.png",
                width: 56 * 1.8,
                height: 69 * 1.8,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                child: Text(
                  "Withdraw ${authViewModel.profileModel?.totalEarnings} to your local bank account?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xffeaeaea),
                              width: 1,
                            ),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 58,
                                alignment: Alignment.center,
                                child: Text(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff00ab6c),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff00ab6c),
                        ),
                        alignment: Alignment.center,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () async {
                              await authViewModel.withdraw(
                                  amount:
                                      "${authViewModel.profileModel?.totalEarnings}");
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 58,
                              alignment: Alignment.center,
                              child: Text(
                                "Yes",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SafeArea(
                  child: SizedBox(
                height: 16,
              ))
            ]));
      },
    );
  }
}
