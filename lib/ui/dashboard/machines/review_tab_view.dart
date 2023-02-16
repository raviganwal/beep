import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/ui/widget/utility/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:beep/core/date_extension.dart';
import 'dart:math';

class ReviewTabView extends StatefulWidget {
  const ReviewTabView({Key? key}) : super(key: key);

  @override
  State<ReviewTabView> createState() => _ReviewTabViewState();
}

class _ReviewTabViewState extends State<ReviewTabView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final machineViewModel = context.read<MachineViewModel>();
      await machineViewModel.getMachineReviews();
    });
  }

  _starWidget(String? rating) {
    if (rating == null || rating.isEmpty) return [const SizedBox()];
    double? numOfStar = double.tryParse(rating);
    if (numOfStar == null) return;
    int stars = numOfStar.toInt();
    List<Widget> list = [];
    for (int i = 0; i < stars; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(right: 12),
        child: SvgPicture.asset(
          'assets/svg/star.svg',
          width: 19,
          height: 19,
        ),
      ));
    }
    int greyStars = 5 - list.length;
    for (int i = 0; i < greyStars; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(right: 12),
        child: SvgPicture.asset(
          'assets/svg/star.svg',
          width: 19,
          height: 19,
          color: Colors.grey.shade300,
        ),
      ));
    }
    return list;
  }

  _chipWidget(String? remarks) {
    if (remarks == null || remarks.isEmpty) return [const SizedBox()];
    List remarksArr = remarks.split(',');
    List<Widget> list = [];
    for (int i = 0; i < remarksArr.length; i++) {
      list.add(
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
                remarksArr.elementAt(i),
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xff00ab6c),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
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
              itemCount: machineViewModel.reviewsList.length,
              itemBuilder: (context, index) {
                final review = machineViewModel.reviewsList.elementAt(index);
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
                      if (review.createdAt != null)
                        Row(
                          children: [
                            Text(
                              review.createdAt!.toyyyyMMddhhmmssParse
                                  .toMMMDddyyyyhhmma,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
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
                        children: _starWidget(review.rating),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        review.message.toString(),
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
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
                      Wrap(
                        direction: Axis.horizontal,
                        children: _chipWidget(review.remarks),
                        runSpacing: 8,
                        spacing: 8,
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
