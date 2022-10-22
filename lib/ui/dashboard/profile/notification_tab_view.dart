import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTabView extends StatefulWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  State<NotificationTabView> createState() => _NotificationTabViewState();
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Notifications'),
  Tab(text: 'Messages'),
];

class _NotificationTabViewState extends State<NotificationTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                // indicatorWeight: 0,
                indicator: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xff00ab6c), width: 2.0),
                  ),
                ),
                labelColor: const Color(0xff00ab6c),
                labelStyle: GoogleFonts.nunitoSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: GoogleFonts.nunitoSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelColor: const Color(0xff898989),
                tabs: tabs,
              ),
            ),
            body: TabBarView(children: <Widget>[
              ListView(
                children: [
                  Container(
                    height: 118,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    color: Color(0xffe7faf3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New Issues Reported",
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Tue, Sep 13",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff898989),
                                fontSize: 13,
                                fontFamily: "Nunito Sans",
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView(
                children: [
                  Container(
                    height: 162,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 24),
                    color: Color(0xffe7faf3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Congratulations",
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff00ab6c),
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Tue, Sep 13",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xff898989),
                                fontSize: 13,
                                fontFamily: "Nunito Sans",
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore",
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xff212121),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff00ab6c),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 7, ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]));
      }),
    );
  }
}
