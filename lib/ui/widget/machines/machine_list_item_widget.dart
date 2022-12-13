import 'package:beep/core/app_locator.dart';
import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/service/navigation_service.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/ui/dashboard/machines/machine_detail_view.dart';
import 'package:beep/ui/widget/utility/badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MachineListItemWidget extends StatelessWidget {
  final Machine machine;
  final GestureTapCallback onTap;

  const MachineListItemWidget(
      {required this.machine, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, right: 8),
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
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 4, bottom: 21, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 122,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (machineViewModel.machineStatusStr(
                                  machine: machine) !=
                              null) ...[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: machineViewModel.machineStatusStr(
                                            machine: machine) ==
                                        "Private"
                                    ? const Color(0xFF00AB6C).withOpacity(.2)
                                    : const Color(0xff828282).withOpacity(.2),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              child: Text(
                                machineViewModel.machineStatusStr(
                                    machine: machine),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: machineViewModel.machineStatusStr(
                                              machine: machine) ==
                                          "Private"
                                      ? const Color(0xFF00AB6C)
                                      : const Color(0xff828282),
                                  fontSize: 7,
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            machineViewModel.checkMachineStatus(
                                            machine: machine) ==
                                        MachineStatus.offline ||
                                    machineViewModel.machineStatusStr(
                                            machine: machine) ==
                                        "Maintenance"
                                ? 'assets/png/machine-image-offline.png'
                                : 'assets/png/machine-image.png',
                            width: 83,
                            height: 102,
                          ),
                          if (machine.err == AppStatus.offline)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Center(
                                child: Container(
                                  width: 74,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xffeaeaea),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    "Offline",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunitoSans(
                                      color: const Color(0xff898989),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      width: 122,
                      child: machine.rating == null
                          ? const SizedBox(
                              height: 16,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset('assets/svg/star.svg'),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  machine.rating.toString(),
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
                            machineViewModel.checkMachineStatus(
                                            machine: machine) ==
                                        MachineStatus.offline ||
                                    machineViewModel.machineStatusStr(
                                            machine: machine) ==
                                        "Maintenance"
                                ? 'assets/svg/foam-icon-grey.svg'
                                : machine.foamTank == AppStatus.foamNormal
                                    ? 'assets/svg/foam-icon.svg'
                                    : 'assets/svg/foam-icon-red.svg',
                          ),
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
                            borderRadius: BorderRadius.circular(3),
                            color: machine.foamTank == AppStatus.foamNormal
                                ? const Color(0xffeaeaea)
                                : const Color(0xffde2800).withOpacity(.15),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: machine.foamTank == "0" ? 122 : 22,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: machineViewModel.checkMachineStatus(
                                            machine: machine) ==
                                        MachineStatus.offline ||
                                    machineViewModel.machineStatusStr(
                                            machine: machine) ==
                                        "Maintenance"
                                ? const Color(0xffc4c4c4)
                                : machine.foamTank == AppStatus.foamNormal
                                    ? const Color(0xff00dd8d)
                                    : const Color(0xffde2800),
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
                          SvgPicture.asset(machineViewModel.checkMachineStatus(
                                          machine: machine) ==
                                      MachineStatus.offline ||
                                  machineViewModel.machineStatusStr(
                                          machine: machine) ==
                                      "Maintenance"
                              ? 'assets/svg/water-icon-grey.svg'
                              : machine.waterTank == AppStatus.waterNormal
                                  ? 'assets/svg/water-icon.svg'
                                  : 'assets/svg/water-icon-red.svg'),
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
                            borderRadius: BorderRadius.circular(3),
                            color: machine.waterTank == AppStatus.waterNormal
                                ? const Color(0xffeaeaea)
                                : const Color(0xffde2800).withOpacity(.15),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: machine.waterTank == AppStatus.waterNormal
                              ? 122
                              : 22,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: machineViewModel.checkMachineStatus(
                                            machine: machine) ==
                                        MachineStatus.offline ||
                                    machineViewModel.machineStatusStr(
                                            machine: machine) ==
                                        "Maintenance"
                                ? const Color(0xffc4c4c4)
                                : machine.waterTank == AppStatus.waterNormal
                                    ? const Color(0xff00ab6c)
                                    : const Color(0xffde2800),
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
                        machine.machineName.toString(),
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
                          fontSize: 11,
                          height: 1.54545454545,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      width: 132,
                      child: Text(
                        machine.address.toString(),
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff898989),
                          height: 1.54545454545,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (machine.issues != AppStatus.noIssues)
          BadgeWidget(
            count: machine.issues.toString(),
          ),
      ],
    );
  }
}
