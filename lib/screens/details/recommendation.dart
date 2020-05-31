import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/models/feature_movies_model.dart';
import 'package:moofies/models/recommedation_model.dart';
import 'package:moofies/screens/details/movie_details.dart';
import 'package:moofies/services/api.dart';
import 'package:moofies/widgets/shimmer_effect.dart';

class Recommendation extends StatefulWidget {
  final iD;
  final type;

  const Recommendation({Key key, this.iD, this.type}) : super(key: key);
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Future<List<RecommendationModel>> recommendedMovies;
  bool showHeading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recommendedMovies = Api().getRecommendations(widget.type, widget.iD);
    print(widget.iD);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return showHeading
        ? Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15,
              bottom: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Recommended",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    width: screenWidth * 0.55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 1,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: screenHeight * 0.4,
                    child: FutureBuilder(
                      future: recommendedMovies,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length == 0) {
                            setState(() {
                              showHeading = false;
                            });
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // int count = 0;
                                    // Navigator.popUntil(context, (route) {
                                    //   return count++ == 1;
                                    // });
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => MovieDetails(
                                                  snapshot: snapshot,
                                                  type: widget.type,
                                                  id: index,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ShimmerImage(
                                          elevation: 3,
                                          shaderAvailable: false,
                                          imageUrl: Api().getPosterImage(
                                              snapshot.data[index].posterPath),
                                          height: screenHeight * 0.2,
                                          width: screenWidth * 0.3,
                                          cornerRadius: 25,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
