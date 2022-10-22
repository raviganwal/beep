import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/utility/no_data_widget.dart';

class ReviewTabView extends StatefulWidget {
  const ReviewTabView({Key? key}) : super(key: key);

  @override
  State<ReviewTabView> createState() => _ReviewTabViewState();
}

class _ReviewTabViewState extends State<ReviewTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 28, bottom: 18),
              child: Row(
                children: [
                  Text(
                    "Customer Reviews",
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset('assets/svg/filter-icon.svg'),
                      )),
                ],
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          Text(
                            "Sep 12, 2022 - 3:45 PM",
                            style: GoogleFonts.nunitoSans(
                              color: Color(0xff898989),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xffeaeaea),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/star.svg',
                            width: 19,
                            height: 19,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            'assets/svg/star.svg',
                            width: 19,
                            height: 19,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            'assets/svg/star.svg',
                            width: 19,
                            height: 19,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            'assets/svg/star.svg',
                            width: 19,
                            height: 19,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            'assets/svg/star-empty.svg',
                            width: 19,
                            height: 19,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "It was my experience and I can tell you that I’m SATISFIED with this service!",
                        style: TextStyle(
                          color: Color(0xff212121),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xffeaeaea),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
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
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Good Location",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color: Color(0xff00ab6c),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffe7faf3),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Clean",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    color: Color(0xff00ab6c),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },
            ),
            // SizedBox(
            //     height: MediaQuery.of(context).size.height / 1.5,
            //     child: const NoDataWidget())
          ],
        ),
      ),
    );
  }
}
