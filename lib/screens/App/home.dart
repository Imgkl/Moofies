import 'package:flutter/material.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/App/feature.dart';
import 'package:moofies/services/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
