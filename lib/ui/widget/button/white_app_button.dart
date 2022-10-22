import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteAppButton extends StatelessWidget {
  final String title;
  final Color? borderColor;
  final GestureTapCallback onTap;

  WhiteAppButton(
      {Key? key,
      required this.onTap,
      required this.title,
      this.borderColor = const Color(0xffeaeaea)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? const Color(0xffeaeaea),
          width: 1,
        ),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 58,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              title,
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
    );
  }
}
