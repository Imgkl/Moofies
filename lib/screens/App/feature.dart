import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/screens/movie_details/movie_details.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/widgets/shimmer_effect.dart';


class HomePageFeaturedWidget extends StatelessWidget {
  final AsyncSnapshot<List<FeaturedMovieModel>> snapshot;
  const HomePageFeaturedWidget({
    Key key,
    this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     // Text(
        //     //   "Trending",
        //     //   style: TextStyle(fontSize: 30),
        //     // ),
        //     // Container(
        //     //   width: 50,
        //     //   child: Divider(
        //     //     thickness: 3,
        //     //   ),
        //     // )
        //   ],
        // ),
        // SizedBox(
        //   height: screenHeight * 0.03,
        // ),
        Container(
          height: screenHeight * 0.4,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, id) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MovieDetails(
                              snapshot: snapshot,
                              id: id,
                            )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ShimmerImage(
                          shaderAvailable: false,
                          imageUrl: Api()
                              .getPosterImage(snapshot.data[id].posterPath),
                          height: screenHeight * 0.4,
                          width: screenWidth * 0.6,
                          cornerRadius: 25,
                          fit: BoxFit.cover,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0, left: 15),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Container(
                        //           width: screenWidth * 0.6,
                        //           child: Text(
                        //             "${snapshot.data[id].originalTitle}",
                        //             style: TextStyle(fontSize: 15),
                        //           )),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 8.0),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: <Widget>[
                        //             Text("${snapshot.data[id].lang} | "
                        //                 .toUpperCase()),
                        //             Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: <Widget>[
                        //                 Icon(
                        //                   LineIcons.star,
                        //                   size: 15,
                        //                   color: Colors.yellow,
                        //                 ),
                        //                 Text(" ${snapshot.data[id].rating}"),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
