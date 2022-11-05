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

class SearchSchoolView extends StatefulWidget {
  const SearchSchoolView({Key? key}) : super(key: key);

  @override
  State<SearchSchoolView> createState() => _SearchSchoolViewState();
}

class _SearchSchoolViewState extends State<SearchSchoolView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final schoolViewModel = context.read<SchoolViewModel>();
      schoolViewModel.searchArticles(query: 'a');
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
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
              title: Hero(
                tag: "search",
                transitionOnUserGestures: true,
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    onChanged: (query) {
                      schoolViewModel.searchArticles(query: query);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.nunitoSans(
                          color: const Color(0xFF898989),
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              actions: [
                SvgPicture.asset(
                  'assets/svg/search_icon.svg',
                ),
                const SizedBox(
                  width: 24,
                )
              ],
            ),
          ),
        ),
        body: ListView.separated(
          itemCount: schoolViewModel.searchArticleList.length,
          itemBuilder: (context, index) {
            final article = schoolViewModel.searchArticleList.elementAt(index);
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
                  const SizedBox(height: 13),
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
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1,
              color: Colors.grey.withOpacity(.1),
            );
          },
        ));
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
