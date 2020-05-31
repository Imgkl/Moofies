import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/screens/details/cast.dart';
import 'package:moofies/screens/details/genre_and_tag_line.dart';
import 'package:moofies/screens/details/about.dart';
import 'package:moofies/screens/details/rating_bar.dart';
import 'package:moofies/screens/details/recommendation.dart';
import 'package:moofies/screens/details/release_info.dart';
import 'package:moofies/screens/details/series_info.dart';
import 'package:moofies/widgets/where_to_watch.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CustomBottomSheet extends StatefulWidget {
  final moviedetail;
  final type;
  final id;

  const CustomBottomSheet({Key key, this.moviedetail, this.type, this.id})
      : super(key: key);
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetOpen;
  double sheetClose;
  bool isExpanded = false;
  bool iconChange = true;
  Animation<double> animation;
  AnimationController _controller;
  ScrollController _scrollController = ScrollController();
  bool absorbTouch = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 100)).whenComplete(() {
      setState(() {
        sheetClose = MediaQuery.of(context).size.height * 0.2;
        sheetOpen = MediaQuery.of(context).size.height * 0.76;
      });
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300));
      animation = Tween<double>(begin: sheetOpen, end: sheetClose).animate(
          CurvedAnimation(
              parent: _controller,
              curve: Curves.easeIn,
              reverseCurve: Curves.easeOut))
        ..addListener(() {
          setState(() {});
        });
    });
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: animation != null ? animation.value : 100,
          left: 0,
          child: GestureDetector(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      child: Container(
                        child: iconChange
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black,
                                  highlightColor: Colors.white,
                                  child: Icon(FontAwesomeIcons.arrowUp),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.arrowDown,
                                    color: Colors.black),
                              ),
                      ),
                      onPressed: () {
                        if (!isExpanded) {
                          _controller.forward();
                          setState(() {
                            isExpanded = !isExpanded;
                            iconChange = !iconChange;
                            absorbTouch = !absorbTouch;
                          });
                        } else if (isExpanded) {
                          _controller.reverse();
                          setState(() {
                            isExpanded = !isExpanded;
                            absorbTouch = !absorbTouch;
                            iconChange = !iconChange;
                            _scrollController.animateTo(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.linear);
                          });
                        } else {
                          return;
                        }
                      }),
                ),
                SheetContainer(
                  allowTouch: absorbTouch,
                  scrollControl: _scrollController,
                  type: widget.type,
                  id: widget.id,
                  movieDetails: widget.moviedetail,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SheetContainer extends StatefulWidget {
  final ScrollController scrollControl;
  final bool allowTouch;
  final movieDetails;
  final type;
  final id;

  const SheetContainer(
      {Key key,
      this.movieDetails,
      this.type,
      this.id,
      this.scrollControl,
      this.allowTouch})
      : super(key: key);

  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {
  ScrollController _scrollContoller = ScrollController();

  Future<Map> getTrailer() async {
    var url =
        "https://api.themoviedb.org/3/${widget.type}/${widget.id}?api_key=488b24a89214f602dec537c161df5303&append_to_response=credits,similar,videos";
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return Future.error("Failed to establish connection");
    }
  }

  _launchURLTrailer(var videos) async {
    if (videos.length != 0) {
      String key;
      for (int i = videos.length - 1; i >= 0; i--) {
        if (videos[i]['type'] == 'Trailer') {
          key = videos[i]['key'];
          break;
        }
        continue;
      }
      String url = "https://www.youtube.com/embed/$key?autoplay=1";
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        throw 'Could Not launch url';
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrailer();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.allowTouch,
      child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: widget.movieDetails,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  if (snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: SingleChildScrollView(
                        controller: widget.scrollControl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GenreTagLine(snapshot: snapshot),
                            Rating(snapshot: snapshot),
                            widget.type == "tv"
                                ? SeriesInfo(
                                    snapshot: snapshot,
                                  )
                                : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FutureBuilder(
                                    future: getTrailer(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      return FloatingActionButton(
                                        onPressed: () {
                                           _launchURLTrailer(snapshot
                                                .data['videos']['results']);
                                        },
                                        heroTag: null,
                                        backgroundColor: Colors.red,
                                        child: Icon(LineIcons.youtube_square),
                                      );
                                    }),
                                snapshot.data.homePage.length > 2
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            launch(snapshot.data.homePage,
                                                forceSafariVC: false);
                                          },
                                          child: Material(
                                            elevation: 0,
                                            child: Container(
                                                color: Colors.transparent,
                                                child: snapshot.data.homePage
                                                        .contains("netflix")
                                                    ? WhereToWatch(
                                                        path:
                                                            "assets/netflix.png",
                                                      )
                                                    : snapshot.data.homePage
                                                            .contains("amazon")
                                                        ? WhereToWatch(
                                                            path:
                                                                "assets/amazon.png")
                                                        : snapshot.data.homePage
                                                                .contains(
                                                                    "disney")
                                                            ? WhereToWatch(
                                                                path:
                                                                    "assets/hotstar.png")
                                                            : snapshot.data
                                                                    .homePage
                                                                    .contains(
                                                                        "apple")
                                                                ? WhereToWatch(
                                                                    path:
                                                                        "assets/apple.png")
                                                                : WhereToWatch(
                                                                    notGeneric:
                                                                        false)),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            About(snapshot: snapshot),
                            CastDetails(snapshot: snapshot, type: widget.type),
                            Recommendation(
                                iD: snapshot.data.id, type: widget.type),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            )
                          ],
                        ),
                      ),
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
          ))),
    );
  }
}
