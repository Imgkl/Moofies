import 'package:flutter/material.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/genre_model.dart';
import 'package:moofies/screens/details/movie_details.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/widgets/shimmer_effect.dart';
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

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
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
        body: PreloadPageView.builder(
            controller:
                PreloadPageController(viewportFraction: 0.7, initialPage: 2),
            itemCount: 4,
            preloadPagesCount: 4,
            itemBuilder: (context, mainIndex) {
              return PreloadPageView.builder(
                  itemCount: 5,
                  preloadPagesCount: 5,
                  controller: controllers[mainIndex],
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  onPageChanged: (page) {
                    _animatePage(page, mainIndex);
                  },
                  itemBuilder: (context, index) {
                    var hitIndex = (mainIndex * 5) + index;

                    return FutureBuilder<List<FeaturedMovieModel>>(
                      future: featuredMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                          snapshot: snapshot,
                                          type: "tv",
                                          id: hitIndex,
                                        )));
                              },
                              child: Hero(
                                tag: snapshot.data[hitIndex],
                                child: ShimmerImage(
                                  shaderAvailable: false,
                                  imageUrl: Api().getPosterImage(
                                      snapshot.data[hitIndex].posterPath),
                                  height: screenHeight * 0.45,
                                  width: screenWidth * 0.7,
                                  cornerRadius: 25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ));
                        }
                      },
                    );
                  });
            }));
  }
}
