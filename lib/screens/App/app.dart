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
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print(isSwitched);
//this goes in as one of the children in our column

    return Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          
        ),
        body: PageView(
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
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: screenHeight * 0.08,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.jumpToPage(0);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Icon(LineIcons.home), Text("Home")],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.jumpToPage(1);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(LineIcons.search),
                        Text("Explore")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.jumpToPage(2);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Icon(LineIcons.user), Text("You")],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: isSwitched ?Icon(LineIcons.television): Icon(LineIcons.ticket),
          onPressed: () {
          setState(() {
            isSwitched = !isSwitched;
          });
        }));
  }
}
