import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsRichText extends StatelessWidget {
  final GestureTapCallback? onTap;

  const TermsRichText({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        text: TextSpan(
          text: 'By creating an account you agree to beep ',
          style: GoogleFonts.nunitoSans(
            color: const Color(0xff212121),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service and Privacy Policy',
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xFF00AB6C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
