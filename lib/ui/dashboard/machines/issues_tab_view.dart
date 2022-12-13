import 'dart:io';

import 'package:beep/core/date_extension.dart';
import 'package:beep/core/model/report_options_model.dart';
import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/core/viewmodel/machine_view_model.dart';
import 'package:beep/ui/widget/button/app_button.dart';
import 'package:beep/ui/widget/button/white_app_button.dart';
import 'package:beep/ui/widget/dialog/on_pick_image_dialog.dart';
import 'package:beep/ui/widget/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/utility/no_data_widget.dart';

class IssuesTabView extends StatefulWidget {
  const IssuesTabView({Key? key}) : super(key: key);

  @override
  State<IssuesTabView> createState() => _IssuesTabViewState();
}

class _IssuesTabViewState extends State<IssuesTabView> {
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final machineViewModel = context.read<MachineViewModel>();
      machineViewModel.getReportOptions();
      machineViewModel.getIssues();
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
                      onTap: () {
                        reportModal();
                      },
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

  reportModal() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        final machineViewModel = context.watch<MachineViewModel>();
        return SafeArea(
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24),
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Text(
                      "Report",
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24),
                child: Text(
                  "What issue are you facing?",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              machineViewModel.reportOptionsList.isEmpty
                  ?  Center(
                    child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(8),
                        child: const CircularProgressIndicator()),
                  )
                  : Flexible(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: machineViewModel.reportOptionsList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ReportOption model = machineViewModel
                              .reportOptionsList
                              .elementAt(index);
                          return Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: const Color(0xff00ab6c),
                              disabledColor: const Color(0xff00ab6c),
                              toggleableActiveColor: const Color(0xff00ab6c),
                            ),
                            child: RadioListTile<ReportOption>(
                              title: Text(
                                model.issue.toString(),
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              value: model,
                              groupValue: machineViewModel.selectedReportOption,
                              onChanged: (ReportOption? value) {
                                machineViewModel.selectedReportOption = value!;
                              },
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24),
                child: Text(
                  "Attach Photo",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffeaeaea),
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16),
                      child: SvgPicture.asset("assets/svg/photo_icon.svg"),
                    ),
                    Expanded(
                        child: Text(
                      machineViewModel.pickedFile != null
                          ? machineViewModel.pickedFile!.path.split('/').last
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                    InkWell(
                      onTap: () async {
                        XFile? pickedFile = await showModalBottomSheet<XFile>(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return const OnPickImageDialog();
                            });
                        if (pickedFile != null) {
                          machineViewModel.pickedFile = pickedFile!;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        child: SizedBox(
                          width: 87,
                          child: Text(
                            "Upload",
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
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24),
                child: Text(
                  "Write a Comment",
                  style: GoogleFonts.nunitoSans(
                    color: const Color(0xff212121),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 24,
                    right: 24),
                child: AppTextField(
                  controller: _commentController,
                  hintText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Write a comment';
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  textAlign: TextAlign.center,
                  maxLines: 6,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xffeaeaea),
                              width: 1,
                            ),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
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
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: machineViewModel.status != ViewStatus.loading
                          ? () async {
                              await machineViewModel.submitReport(
                                  comment: _commentController.text);
                              _commentController.clear();
                              machineViewModel.pickedFile = null;
                              if (!mounted) return;
                              Navigator.of(context).pop();
                              await machineViewModel.getIssues();
                            }
                          : null,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff00ab6c),
                        ),
                        alignment: Alignment.center,
                        child: machineViewModel.status == ViewStatus.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.nunitoSans(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
