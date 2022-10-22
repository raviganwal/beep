import 'package:beep/core/model/machine_model.dart';
import 'package:beep/ui/dashboard/machines/add_machine_view.dart';
import 'package:beep/ui/dashboard/machines/machine_detail_view.dart';
import 'package:beep/ui/dashboard/machines/stats_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../../core/viewmodel/machine_view_model.dart';

class MachinesTabView extends StatefulWidget {
  const MachinesTabView({Key? key}) : super(key: key);

  @override
  State<MachinesTabView> createState() => _MachinesTabViewState();
}

class _MachinesTabViewState extends State<MachinesTabView> {
  @override
  void initState() {
    final machineViewModel = context.read<MachineViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      machineViewModel.getAllMachine();
      machineViewModel.needAttentions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4.0),
              blurRadius: 12.0,
            )
          ]),
          child: AppBar(
            titleSpacing: 0,
            elevation: 0,
            title: Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Image.asset(
                  "assets/png/logo.png",
                  width: 59,
                  height: 22,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Control",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff242d29),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/search_icon.svg',
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // IconButton(
          //     onPressed: () async {
          //       await locator<NavigationService>()
          //           .navigateToWidget(const AddMachine());
          //     },
          //     icon: const Icon(Icons.add))
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 17),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Machines",
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          onTap: () async {
                            await locator<NavigationService>()
                                .navigateToWidget(const AddMachineView());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Text(
                              "+ Add Machine",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 312,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        left: 24, bottom: 20, top: 10, right: 24),
                    shrinkWrap: true,
                    itemCount: machineViewModel.machineList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      MachineModel model = machineViewModel.machineList[index];
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 8.0,
                              )
                            ]),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () async {
                              await locator<NavigationService>()
                                  .navigateToWidget(
                                      MachineDetailsView(machine: model));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 21, left: 12, right: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 122,
                                    height: 122,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xffeaeaea),
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Image.asset(
                                      'assets/png/machine-image.png',
                                      width: 83,
                                      height: 102,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    width: 122,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/svg/star.svg'),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "4.3",
                                          style: GoogleFonts.nunitoSans(
                                            color: const Color(0xff212121),
                                            fontSize: 11,
                                            height: 1.45454545455,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 132,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/foam-icon.svg'),
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
                                        width: 132,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xffeaeaea),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 122,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xff00dd8d),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: 132,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svg/water-icon.svg'),
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
                                        width: 132,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xffeaeaea),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 122,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xff00ab6c),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 132,
                                    child: Text(
                                      model.name.toString(),
                                      style: GoogleFonts.nunitoSans(
                                        color: const Color(0xff212121),
                                        fontSize: 11,
                                        height: 1.54545454545,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  SizedBox(
                                    width: 132,
                                    child: Text(
                                      "1234 Address St, Georgia",
                                      style: GoogleFonts.nunitoSans(
                                        color: const Color(0xff898989),
                                        height: 1.54545454545,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(top: 17),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Need Attentions",
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: machineViewModel.attentionsList.isEmpty
                      ? Column(
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
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(
                              left: 24, bottom: 20, top: 15),
                          shrinkWrap: true,
                          itemCount: machineViewModel.attentionsList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            MachineModel model =
                                machineViewModel.attentionsList[index];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 8.0,
                                    )
                                  ]),
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 21, left: 12, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 122,
                                    height: 122,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color(0xffeaeaea),
                                        width: 1,
                                      ),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Image.asset(
                                      'assets/png/machine-image.png',
                                      width: 83,
                                      height: 102,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    width: 122,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset('assets/svg/star.svg'),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          "4.3",
                                          style: GoogleFonts.nunitoSans(
                                            color: const Color(0xff212121),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    width: 132,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/foam-icon.svg',
                                          color: const Color(0xffde2800),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Foam",
                                          style: GoogleFonts.nunitoSans(
                                            color: const Color(0xff212121),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 132,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xFFFADFD9),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 20,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xffde2800),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    width: 132,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/water-icon.svg',
                                          color: const Color(0xffde2800),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Water",
                                          style: GoogleFonts.nunitoSans(
                                            color: const Color(0xff212121),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 132,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xFFFADFD9),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        width: 20,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xffde2800),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    model.name.toString(),
                                    style: GoogleFonts.nunitoSans(
                                      color: const Color(0xff212121),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "1234 Address St, Georgia",
                                    style: GoogleFonts.nunitoSans(
                                      color: const Color(0xff898989),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 20,
                            );
                          },
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
