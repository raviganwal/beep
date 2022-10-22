import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/utility/no_data_widget.dart';

class StatsTabView extends StatefulWidget {
  const StatsTabView({Key? key}) : super(key: key);

  @override
  State<StatsTabView> createState() => _StatsTabViewState();
}

class _StatsTabViewState extends State<StatsTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 30),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xffeaeaea),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Image.asset(
                          'assets/png/machine-image.png',
                          width: 134,
                          height: 165,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Machine Status",
                            style: GoogleFonts.nunitoSans(
                              color: Colors.black,
                              fontSize: 13,
                              height: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffe7faf3),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/circle-check.svg',
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Operate Normally",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff00ab6c),
                                    fontSize: 13,
                                    height: 1.69,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Container(
                            width: 180,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/foam-icon.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Foam",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff212121),
                                    fontSize: 11,
                                    height: 1.54545454545,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 180,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xffeaeaea),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 166,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xff00dd8d),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: 180,
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/water-icon.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Water",
                                  style: GoogleFonts.nunitoSans(
                                    color: const Color(0xff212121),
                                    fontSize: 11,
                                    height: 1.54545454545,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 180,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xffeaeaea),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 166,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xff00ab6c),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Text(
                    "Machine Address",
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 13,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "1234 Address St, Georgia",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      height: 1.52,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              child: DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: TabBar(
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            // indicatorWeight: 0,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Color(0xff00ab6c), width: 5.0),
                              ),
                            ),
                            labelColor: const Color(0xff00ab6c),
                            labelStyle: GoogleFonts.nunitoSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelStyle: GoogleFonts.nunitoSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            unselectedLabelColor: const Color(0xff898989),
                            tabs: const [
                              Tab(
                                text: "Daily Stats",
                              ),
                              Tab(
                                text: "Monthly Stats",
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 400, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: const TabBarView(children: <Widget>[
                              NoDataWidget(),
                              NoDataWidget(),
                            ]))
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
