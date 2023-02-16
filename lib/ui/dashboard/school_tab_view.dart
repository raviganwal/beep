import 'package:beep/core/viewmodel/school_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolTabView extends StatefulWidget {
  const SchoolTabView({Key? key}) : super(key: key);

  @override
  State<SchoolTabView> createState() => _SchoolTabViewState();
}

class _SchoolTabViewState extends State<SchoolTabView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final schoolViewModel = context.read<SchoolViewModel>();
      schoolViewModel.getArticles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final schoolViewModel = context.watch<SchoolViewModel>();
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
                  "School",
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
              Hero(
                tag: "search",
                transitionOnUserGestures: true,
                child: Material(
                  type: MaterialType.transparency,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: IconButton(
                      onPressed: () {
                        schoolViewModel.navigateSearchView();
                      },
                      icon: SvgPicture.asset(
                        'assets/svg/search_icon.svg',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: GridView.custom(
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: [
            QuiltedGridTile(
                1,
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 4),
            QuiltedGridTile(
                1,
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 1
                    : 2),
            QuiltedGridTile(
                1,
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 1
                    : 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: schoolViewModel.articleList.length,
          (context, index) {
            final article = schoolViewModel.articleList.elementAt(index);
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                  top: 24, bottom: 25, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.articleTitle.toString(),
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff212121),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.articleBody.toString(),
                    style: GoogleFonts.nunitoSans(
                      color: const Color(0xff898989),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 9),
                  InkWell(
                    onTap: () {
                      _launchInBrowser(article.articleUrl.toString());
                    },
                    child: Text(
                      "Read more",
                      style: GoogleFonts.nunitoSans(
                        color: const Color(0xff00ab6c),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
