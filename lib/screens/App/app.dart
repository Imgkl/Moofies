import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/App/home.dart';
import 'package:moofies/screens/App/profile.dart';
import 'package:moofies/screens/App/search.dart';
import 'package:moofies/screens/TV/home_tv.dart';
import 'package:moofies/screens/TV/search_tv.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/services/prefs.dart';
import 'package:moofies/widgets/bottom_navBar.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<List<FeaturedMovieModel>> featuredMovies;
  Future<List<GenreModel>> genreList;
  bool isSwitched = true;

  PageController _controller = PageController(initialPage: 0);
  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    genreList = _api.getGenreList();
    setState(() {
      isSwitched = LocalStorage.getTrendingTab();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(isSwitched);
//this goes in as one of the children in our column

    return SafeArea(
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                isSwitched
                    ? Home(
                        type: "movie",
                      )
                    : HomeTV(
                        type: "tv",
                      ),
                isSwitched ? Search(type: "movie") : SearchTV(type: "tv"),
                Profile(),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0, bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton.extended(
                          
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xff2c362f),
                            label: isSwitched
                                ? Row(
                                    children: <Widget>[
                                      Icon(LineIcons.television),
                                      Text(" TV")
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Icon(LineIcons.ticket),
                                      Text(" MOVIE")
                                    ],
                                  ),
                            onPressed: () {
                              setState(() {
                                isSwitched = !isSwitched;
                                LocalStorage.setTrendingTab(isSwitched);
                              });
                            }),
                      ),
                    ),
                    HighlightNavigationBar(
                        height: 100,
                        icons: [
                          IconButton(
                              icon: Icon(LineIcons.home),
                              onPressed: () {
                                setState(() {
                                  _controller.jumpToPage(0);
                                });
                              }),
                          IconButton(
                              icon: Icon(LineIcons.search),
                              onPressed: () {
                                setState(() {
                                  _controller.jumpToPage(1);
                                });
                              }),
                          IconButton(
                              icon: Icon(LineIcons.user),
                              onPressed: () {
                                setState(() {
                                  _controller.jumpToPage(2);
                                });
                              }),
                        ],
                        onchanged: (int) {
                          print(int);
                        },
                      
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
