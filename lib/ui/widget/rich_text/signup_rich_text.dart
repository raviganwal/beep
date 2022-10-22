import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupRichText extends StatelessWidget {
  final GestureTapCallback? onTap;

  const SignupRichText({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        text: TextSpan(
          text: 'Don’t have an account? ',
          style: GoogleFonts.nunitoSans(
            color: const Color(0xff898989),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'Sign Up',
                style:  GoogleFonts.nunitoSans(
                  color: const Color(0xff00ab6c),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
