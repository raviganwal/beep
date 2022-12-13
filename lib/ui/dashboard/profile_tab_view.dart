import 'package:beep/ui/dashboard/profile/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../../core/viewmodel/auth_view_model.dart';
import 'profile/my_team/my_team_view.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authViewModel = context.read<AuthViewModel>();
      authViewModel.profile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 281,
                // padding: const EdgeInsets.symmetric(horizontal: 24),
                // margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff00ab6c), Color(0xff025838)],
                )),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 4.0, bottom: 0, left: 24, right: 24),
                        child: Row(
                          children: [
                            const Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Nunito Sans",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100.0),
                                onTap: () async {
                                  await locator<NavigationService>()
                                      .navigateToWidget(
                                          const EditProfileView());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/png/pencil-icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 110,
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 26),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0x26000000), Color(0x00000000)],
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (authViewModel.profileModel != null) ...[
                              Text(
                                "${authViewModel.profileModel?.accountInfo?.firstName} ${authViewModel.profileModel?.accountInfo?.lastName}",
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 28,
                                  height: 1.6,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${authViewModel.getUserRole(role: authViewModel.profileModel!.accountInfo!.userRole!)}",
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 112,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                    top: 281 - 56, left: 24, right: 24, bottom: 37),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1e000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Earnings",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff898989),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        if (authViewModel.profileModel != null)
                          Text(
                            "${authViewModel.profileModel?.totalEarnings}",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff212121),
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        const Spacer(),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4.0),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "View Details",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xff00ab6c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            children: [
              //Account Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Account Information",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(bottom: 21),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/email-icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    if (authViewModel.profileModel != null)
                    Text(
                      "${authViewModel.profileModel?.accountInfo?.email}",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(bottom: 21, top: 25),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/mobile-icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    if (authViewModel.profileModel != null)
                    Text(
                      "${authViewModel.profileModel?.accountInfo?.phone}",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              //Bank Account
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(top: 22),
                child: Text(
                  "Bank Account",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(bottom: 21, top: 15),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/bank-icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    if (authViewModel.profileModel != null)
                    Text(
                      "${authViewModel.profileModel?.bankAccount?.bankName}",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (authViewModel.profileModel != null)
                    Text(
                      "${authViewModel.profileModel?.bankAccount?.accountNumber}",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff898989),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(top: 22),
                child: Text(
                  "My Team",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24.0, right: 12),
                margin: const EdgeInsets.only(bottom: 21, top: 15),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/team-icon.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    if (authViewModel.profileModel != null)
                    Text(
                      "${authViewModel.profileModel?.teamMembers} Team Member",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff212121),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () async {
                        await locator<NavigationService>()
                            .navigateToWidget(const MyTeamView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        child: Text(
                          "View",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff00ab6c),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                margin: const EdgeInsets.only(bottom: 15, top: 22),
                child: Text(
                  "Referral Code",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffe7faf3),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {},
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/svg/invite-icon.svg"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Invite Operator",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff00ab6c),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "You can share this referral code to partners to join us as a machine operator and earn Rewards",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff898989),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 20),
                  // margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/info-icon.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Terms of Service and Privacy Policy",
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff00ab6c),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: const Color(0xffeaeaea),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xff00ab6c),
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {},
                    child: SizedBox(
                      height: 56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/help-icon.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Need Help? Contact Us",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff00ab6c),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      authViewModel.logout();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Log Out",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff898989),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset("assets/svg/logout-icon.svg")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
