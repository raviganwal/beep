import 'package:beep/core/date_extension.dart';
import 'package:beep/core/model/machine_stats_model.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MonthlyStatsView extends StatefulWidget {
  const MonthlyStatsView({Key? key}) : super(key: key);

  @override
  State<MonthlyStatsView> createState() => _MonthlyStatsViewState();
}

class _MonthlyStatsViewState extends State<MonthlyStatsView> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     final machineViewModel = context.read<MachineViewModel>();
  //     machineViewModel.getMachineStats();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: machineViewModel.monthlyStatsList.length,
      itemBuilder: (context, index) {
        MonthlyStats dailyStats =
            machineViewModel.monthlyStatsList.elementAt(index);
        return Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff00ab6c),
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  "${dailyStats.statYear}-${dailyStats.statMonth}"
                      .toyyyyMMParse
                      .toMMMyyyy,
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff898989),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 29, top: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xffeaeaea),
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              dailyStats.washes.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff212121),
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Washes",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              dailyStats.minutes.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff212121),
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Minutes",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              dailyStats.rating.toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff212121),
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Ratings",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: const Color(0xffeaeaea),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Revenue",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff898989),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          dailyStats.revenue.toString(),
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff00ab6c),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20);
      },
    );
  }
}
