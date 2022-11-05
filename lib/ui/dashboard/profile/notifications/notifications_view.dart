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

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final notificationsViewModel = context.read<NotificationsViewModel>();
    //   notificationsViewModel.getNotifications();
    // });
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
              itemCount: notificationsViewModel.notificationsList.length,
              itemBuilder: (context, index) {
                Message notification =
                    notificationsViewModel.notificationsList.elementAt(index);
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
                          if (notification.notifTitle != null) ...[
                            Text(
                              notification.notifTitle.toString(),
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                          const Spacer(),
                          Text(
                            notification.createdAt!.toyyyyMMddParse.toEEEMMMdd
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
                        notification.notifBody.toString(),
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff212121),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (notification.image != null) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              ApiUrl.imageUrlNotifications +
                                  notification.image!,
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            )),
                      ]
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
}
