import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgeWidget extends StatelessWidget {
  final String count;

  const BadgeWidget({required this.count, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: SizedBox(
        width: 17,
        height: 17,
        child: Stack(
          children: [
            Container(
              width: 17,
              height: 17,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffde2800),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  count,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
