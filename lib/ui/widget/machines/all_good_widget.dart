import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllGoodWidget extends StatelessWidget {
  const AllGoodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset('assets/png/all-good-img.png'),
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              "All Good",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "All machines still work normally, no need to worry.",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                color: const Color(0xff898989),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
