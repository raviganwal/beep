import 'package:beep/core/date_extension.dart';
import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/ui/widget/button/white_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/utility/no_data_widget.dart';

class IssuesTabView extends StatefulWidget {
  const IssuesTabView({Key? key}) : super(key: key);

  @override
  State<IssuesTabView> createState() => _IssuesTabViewState();
}

class _IssuesTabViewState extends State<IssuesTabView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final machineViewModel = context.read<MachineViewModel>();
      await machineViewModel.getIssues();
    });
  }

  @override
  Widget build(BuildContext context) {
    final machineViewModel = context.watch<MachineViewModel>();
    return Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Text(
                "Issues",
                style: GoogleFonts.nunitoSans(
                  color: const Color(0xff212121),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (machineViewModel.issuesList.isNotEmpty)
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: machineViewModel.issuesList.length,
                padding: const EdgeInsets.only(left: 24, right: 24),
                itemBuilder: (context, index) {
                  final issue = machineViewModel.issuesList.elementAt(index);
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
                              issue.createdAt!.toyyyyMMddhhmmssParse
                                  .toMMMDddyyyyhhmma,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            if (issue.status == "0") ...[
                              SvgPicture.asset('assets/svg/close.svg'),
                              const SizedBox(width: 5),
                              Text(
                                "Not fixed",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunitoSans(
                                  color: const Color(0xffde2800),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 1,
                          color: const Color(0xffeaeaea),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Text(
                              "Main Issue:",
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff898989),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              issue.issue.toString(),
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xffde2800),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          issue.comment.toString(),
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: const Color(0xffeaeaea),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () async {
                              if (issue.attachment == null ||
                                  issue.attachment!.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "No attachment found.");
                              } else {
                                Uri uri = Uri.parse(
                                    "${ApiUrl.imageUrlIssues}${issue.attachment}");
                                _launchInBrowser(uri);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/image-icon.svg'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "View Image",
                                    style: GoogleFonts.nunitoSans(
                                      color: const Color(0xff00ab6c),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        if (issue.status == "0") ...[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xff00ab6c),
                                width: 1,
                              ),
                              color: Colors.white,
                            ),
                            child: Material(
                              type: MaterialType.transparency,
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                onTap: () async {
                                  await machineViewModel.markAsFix(
                                      issueId: "${issue.id}");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Mark as Fixed",
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
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                        if (issue.status == "1") ...[
                          Container(
                            height: 1,
                            color: const Color(0xffeaeaea),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Fixed by",
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff898989),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            issue.fixedBy.toString(),
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff212121),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]
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
            const SizedBox(
              height: 23,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffeaeaea),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1e000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: SizedBox(
                        height: 40,
                        width: 180,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/warning-icon.svg'),
                            const SizedBox(width: 10),
                            Text(
                              "Add Issue",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
