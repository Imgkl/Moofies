import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/movies/discover_movie.dart';
import 'package:moofies/screens/movies/trending_movie.dart';
import 'package:moofies/services/api.dart';
import 'package:preload_page_view/preload_page_view.dart';

class Home extends StatefulWidget {
  final type;

  const Home({Key key, this.type}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(8), child: Text('Trending'),),
    1: Text('Discover'),
  };

  final Map<int, Widget> icons =  <int, Widget>{
    0: TrendingMovie(
      type: "movie",
    ),
    1: DiscoverMovie(),
  };
  int sharedValue = 0;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSegmentedControl<int>(
          borderColor: Colors.black,
          selectedColor: Colors.black,
          children: logoWidgets,
          onValueChanged: (int val) {
            setState(() {
              sharedValue = val;
            });
          },
          groupValue: sharedValue,
        ),
      ),
      body: icons[sharedValue],
    );
  }
}
