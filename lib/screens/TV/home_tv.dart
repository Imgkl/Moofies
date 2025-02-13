import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/TV/discover_tv.dart';
import 'package:moofies/screens/trending_tv.dart';
import 'package:moofies/services/api.dart';
import 'package:preload_page_view/preload_page_view.dart';

class HomeTV extends StatefulWidget {
  final type;

  const HomeTV({Key key, this.type}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeTV> {


  @override
  Future<List<FeaturedMovieModel>> featuredMovies;
  List<PreloadPageController> controllers = [];
  Future<List<GenreModel>> genreList;
  Api _api;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 50.0);


  @override
  void initState() {
    super.initState();
    _api = Api();
    controllers = [
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
      PreloadPageController(viewportFraction: 0.6, initialPage: 3),
    ];
    featuredMovies = _api.getFeaturedMovies(widget.type);
    genreList = _api.getGenreList();
  }

  _animatePage(int page, int index) {
    for (int i = 0; i < 4; i++) {
      if (i != index) {
        controllers[i].animateToPage(page,
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(8), child: Text('Trending'),),
    1: Text('Discover'),
  };

  final Map<int, Widget> icons =  <int, Widget>{
    0: TrendingTv(
      type: "tv",
    ),
    1: DiscoverTV(),
  };
  int sharedValue = 0;


  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        // body: FutureBuilder<List<FeaturedMovieModel>>(
        //   future: featuredMovies,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return Padding(
        //         padding: const EdgeInsets.only(left: 10.0),
        //         child: HomePageFeaturedWidget(snapshot: snapshot),
        //       );
        //     } else {
        //       return Center(
        //           child: CircularProgressIndicator(
        //         strokeWidth: 1,
        //       ));
        //     }
        //   },
        // ),
             body: icons[sharedValue],
        );
  }
}
