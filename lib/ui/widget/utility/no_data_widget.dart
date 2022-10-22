import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/png/no-stats.png',
          width: 216,
          height: 208,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "You don’t have any data to show",
          textAlign: TextAlign.center,
          style: GoogleFonts.nunitoSans(
            color: const Color(0xff898989),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
