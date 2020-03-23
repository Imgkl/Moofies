import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/App/feature.dart';
import 'package:moofies/services/api.dart';

class App extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<App> {
  Future<List<FeaturedMovieModel>> featuredMovies;
  Future<List<GenreModel>> genreList;
  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(""),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FeaturedMovieModel>>(
        future: featuredMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: HomePageFeaturedWidget(snapshot: snapshot),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
            ));
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: screenHeight * 0.08,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(LineIcons.home), Text("Home")],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(LineIcons.search), Text("Explore")],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(LineIcons.user), Text("You")],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
