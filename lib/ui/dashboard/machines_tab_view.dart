import 'package:beep/core/app_status.dart';
import 'package:beep/core/model/machine_model.dart';
import 'package:beep/core/viewmodel/auth_view_model.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/ui/dashboard/machines/add_machine_view.dart';
import 'package:beep/ui/dashboard/machines/machine_detail_view.dart';
import 'package:beep/ui/dashboard/machines/stats_tab_view.dart';
import 'package:beep/ui/widget/machines/machine_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/app_locator.dart';
import '../../core/service/navigation_service.dart';
import '../../core/viewmodel/machine_view_model.dart';
import '../widget/machines/all_good_widget.dart';

class MachinesTabView extends StatefulWidget {
  const MachinesTabView({Key? key}) : super(key: key);

  @override
  State<MachinesTabView> createState() => _MachinesTabViewState();
}

class _MachinesTabViewState extends State<MachinesTabView> {
  @override
  void initState() {
    final machineViewModel = context.read<MachineViewModel>();
    final authViewModel = context.read<AuthViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      machineViewModel.getAllMachine(authViewModel: authViewModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    final authViewModel = context.watch<AuthViewModel>();

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
              machineViewModel.searchOpen
                  ? Expanded(
                      // width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              machineViewModel.searchOpen =
                                  !machineViewModel.searchOpen;
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search here'),
                              onChanged: (value) {
                                machineViewModel.searchMachine(query: value);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              if (!machineViewModel.searchOpen)
                IconButton(
                  onPressed: () {
                    machineViewModel.searchOpen = !machineViewModel.searchOpen;
                  },
                  icon: SvgPicture.asset(
                    'assets/svg/search_icon.svg',
                  ),
                ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 344,
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        left: 24, bottom: 20, top: 10, right: 24),
                    shrinkWrap: true,
                    itemCount: machineViewModel.filteredMachineList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Machine machine =
                          machineViewModel.filteredMachineList[index];
                      return MachineListItemWidget(
                          machine: machine,
                          onTap: () async {
                            machineViewModel.selectedMahcine = machine;
                            await locator<NavigationService>()
                                .navigateToWidget(const MachineDetailsView());
                          });
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                machineViewModel.status == ViewStatus.loading
                    ? Container(
                        height: 373,
                      )
                    : machineViewModel.filteredAttentionsList.isEmpty
                        ? const AllGoodWidget()
                        : SizedBox(
                            height: 344,
                            child: ListView.separated(
                              padding: const EdgeInsets.only(
                                  left: 24, bottom: 20, top: 10, right: 24),
                              shrinkWrap: true,
                              itemCount: machineViewModel
                                  .filteredAttentionsList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Machine machine =
                                    machineViewModel.attentionsList[index];
                                return MachineListItemWidget(
                                    machine: machine,
                                    onTap: () async {
                                      machineViewModel.selectedMahcine =
                                          machine;
                                      await locator<NavigationService>()
                                          .navigateToWidget(
                                              const MachineDetailsView());
                                    });
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
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
