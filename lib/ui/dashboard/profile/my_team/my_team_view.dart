import 'package:beep/ui/dashboard/profile/my_team/add_team_member_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Widget build(BuildContext context) {
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
              "My Team",
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
      body: Container(
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
      ),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset('assets/svg/plus-icon.svg'),
        onPressed: () async {
          await locator<NavigationService>()
              .navigateToWidget(const AddTeamMemberView());
        },
      ),
    );
  }

  _passwordUpdated() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(28),
          //     topRight: Radius.circular(28),
          //   ),
          //   color: Colors.white,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Text(
                        "Update Password",
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 39,
              ),
              SvgPicture.asset("assets/svg/machine-added.svg"),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Password Updated",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xff212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: "Done",
                  )),
              const SizedBox(
                height: 53,
              ),
            ],
          ),
        );
      },
    );
  }
}
