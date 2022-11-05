import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/button/app_button.dart';

class ReferralTabView extends StatefulWidget {
  const ReferralTabView({Key? key}) : super(key: key);

  @override
  State<ReferralTabView> createState() => _ReferralTabViewState();
}

class _ReferralTabViewState extends State<ReferralTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            titleSpacing: 0,
            elevation: 0,
            centerTitle: false,
            title: Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Text(
                  "Referral",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff242d29),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 34,
            ),
            Image.asset(
              "assets/png/referral_tab.png",
              width: 203,
              height: 218,
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Spread The Wealth",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Share your personal code with potential operators. After they get their first beep wash booking, you both earn a \$100 each!",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff898989),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 37,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe7faf3),
                  ),
                  child: Center(
                    child: Text(
                      "1",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invite operators by sharing your code",
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "They sign up using your code below into the app",
                        style: GoogleFonts.nunitoSans(
                            color: const Color(0xff898989),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe7faf3),
                  ),
                  child: Center(
                    child: Text(
                      "2",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set up their beep operation",
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Once they set up their beep operation and receive their first beep booking you both earn",
                        style: GoogleFonts.nunitoSans(
                            color: const Color(0xff898989),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe7faf3),
                  ),
                  child: Center(
                    child: Text(
                      "3",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You both earn \$100!",
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Your \$100 will be added to your earnings and be  available for withdrawal immediately",
                        style: GoogleFonts.nunitoSans(
                            color: const Color(0xff898989),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.5),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Terms apply",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff00ab6c),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              onTap: () {},
              title: "Invite Operator",
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
