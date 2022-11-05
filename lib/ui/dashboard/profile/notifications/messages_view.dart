import 'package:beep/core/date_extension.dart';
import 'package:beep/core/model/messages_model.dart';
import 'package:beep/core/model/notification_model.dart';
import 'package:beep/core/service/api_url.dart';
import 'package:beep/core/viewmodel/base_view_model.dart';
import 'package:beep/core/viewmodel/notifications_view_model.dart';
import 'package:beep/ui/widget/app_debug_print.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notificationsViewModel = context.read<NotificationsViewModel>();
      notificationsViewModel.getMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsViewModel = context.watch<NotificationsViewModel>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              // physics: NeverScrollableScrollPhysics(),
              controller: controller,
              itemCount: notificationsViewModel.messagesList.length,
              itemBuilder: (context, index) {
                Message message =
                    notificationsViewModel.messagesList.elementAt(index);
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  // color: const Color(0xffe7faf3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (message.notifTitle != null) ...[
                            Text(
                              message.notifTitle.toString(),
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                          const Spacer(),
                          Text(
                            message.createdAt!.toyyyyMMddParse.toEEEMMMdd
                                .toString(),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.nunitoSans(
                              color: const Color(0xff898989),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        message.notifBody.toString(),
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (message.image != null &&
                          message.image!.isNotEmpty) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              ApiUrl.imageUrlNotifications + message.image!,
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            )),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      if (message.notifUrl != null &&
                          message.notifUrl!.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff00ab6c),
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Uri uri = Uri.parse(message.notifUrl!);
                                _launchInBrowser(uri);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 68,
                                  vertical: 7,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Open",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontFamily: "Nunito Sans",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: const Color(0xffeaeaea),
                );
              },
            ),
          ),
          AnimatedContainer(
            height: notificationsViewModel.status == ViewStatus.loading &&
                    notificationsViewModel.page > 1
                ? 60
                : 0,
            duration: const Duration(milliseconds: 200),
            child: const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    // appDebugPrint(controller.position.extentAfter.toString());
    if (controller.position.extentAfter < 100) {
      final notificationsViewModel = context.read<NotificationsViewModel>();
      if (notificationsViewModel.status == ViewStatus.ready) {
        notificationsViewModel.getMessages();
        appDebugPrint("page count ${notificationsViewModel.page}");
      }
    }
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
