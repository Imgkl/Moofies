import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/screens/details/genre_and_tag_line.dart';
import 'package:moofies/screens/details/about.dart';
import 'package:moofies/screens/details/rating_bar.dart';
import 'package:moofies/screens/details/recommendation.dart';
import 'package:moofies/screens/details/release_info.dart';
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
  Animation<double> animation;
  AnimationController _controller;

  

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
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: animation.value != null ? animation.value : 100,
          left: 0,
          child: GestureDetector(
            // onVerticalDragEnd: (DragEndDetails dragEndDetails) {
            //   if (dragEndDetails.primaryVelocity < 0.0) {
            //     _controller.forward();
            //   } else if (dragEndDetails.primaryVelocity > 0.0) {
            //     _controller.reverse();
            //   } else {
            //     return;
            //   }
            // },
            onTap: () {
              if (isExpanded) {
                _controller.forward();
                setState(() {
                  isExpanded = !isExpanded;
                });
              } else if (!isExpanded) {
                _controller.reverse();
                setState(() {
                  isExpanded = !isExpanded;
                });
              } else {
                return;
              }
            },
            child: SheetContainer(
              type: widget.type,
              id: widget.id,
              movieDetails: widget.moviedetail,
            ),
          ),
        ),
      ],
    );
  }
}

class SheetContainer extends StatefulWidget {
  final movieDetails;
  final type;
  final id;

  const SheetContainer({Key key, this.movieDetails, this.type, this.id})
      : super(key: key);

  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends State<SheetContainer> {


  

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
    return Material(
        color: Colors.transparent,
        elevation: 3,
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
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        GenreTagLine(snapshot: snapshot),
                        Rating(snapshot: snapshot),
                        // ReleaseInfo(snapshot: snapshot),
                        FutureBuilder(
                          future: getTrailer(),
                          builder: (context,AsyncSnapshot snapshot){
                            return Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: FloatingActionButton(onPressed: (){
                                _launchURLTrailer(snapshot.data['videos']['results']);
                              }, backgroundColor: Colors.red, child: Icon(LineIcons.youtube_play),),
                            );

                        }),
                        About(snapshot: snapshot),
                        Recommendation(iD: snapshot.data.id, type: widget.type)
                      ],
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
        )));
  }
}
