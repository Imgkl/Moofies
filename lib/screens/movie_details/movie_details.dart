import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moofies/screens/movie_details/about.dart';
import 'package:moofies/screens/movie_details/bottom_nav.dart';
import 'package:moofies/screens/movie_details/fab_button.dart';
import 'package:moofies/screens/movie_details/genre_and_tag_line.dart';
import 'package:moofies/screens/movie_details/rating_bar.dart';
import 'package:moofies/screens/movie_details/release_info.dart';
import 'package:moofies/services/api.dart';
import 'bg_image.dart';

class MovieDetails extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final id;

  const MovieDetails({Key key, this.snapshot, this.id}) : super(key: key);
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Future movieDetails;

  Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    movieDetails = _api.getMovieInfo(widget.snapshot.data[widget.id].id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BgImage(
                snapshot: widget.snapshot,
                id: widget.id,
              ),
              FutureBuilder(
                  future: movieDetails,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          GenreTagLine(snapshot: snapshot),
                          Rating(snapshot: snapshot),
                          ReleaseInfo(snapshot: snapshot),
                          About(snapshot: snapshot),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return CircularProgressIndicator(
                        strokeWidth: 1,
                      );
                    }
                    return CircularProgressIndicator(
                      strokeWidth: 1,
                    );
                  }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FabButton(),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5.0,
            child: BottomBar()));
  }
}
