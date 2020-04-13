import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/screens/details/custom_sheet.dart';
import 'package:moofies/services/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bg_image.dart';

class MovieDetails extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final id;
  final type;

  const MovieDetails({Key key, this.snapshot, this.id, this.type})
      : super(key: key);
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
    movieDetails =
        _api.getMovieInfo(widget.snapshot.data[widget.id].id, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.85,
            child: BgImage(
              snapshot: widget.snapshot,
              id: widget.id,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(LineIcons.long_arrow_left),
                    )),

                margin: const EdgeInsets.only(
                    bottom: 6.0), //Same as `blurRadius` i guess
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            // alignment: Alignment.bottomCenter,
            // heightFactor: 0.45,
            // child: Material(
            //   color: Colors.transparent,
            //   elevation: 3,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(40),
            //           topRight: Radius.circular(40)),
            //       color: Colors.white,
            //     ),
            //  child: FutureBuilder(
            //    future: movieDetails,
            //    builder: (context, snapshot) {
            //      if (!snapshot.hasData) {
            //        return CircularProgressIndicator();
            //      }
            //      if (snapshot.hasData) {
            //        return Column(
            //          children: <Widget>[
            //            GenreTagLine(snapshot: snapshot),4
            //            Rating(snapshot: snapshot),
            //            ReleaseInfo(snapshot: snapshot),
            //            About(snapshot: snapshot),
            //          ],
            //        );
            //      }
            //      if (snapshot.hasError) {
            //        return CircularProgressIndicator(
            //          strokeWidth: 1,
            //        );
            //      }
            //      return CircularProgressIndicator(
            //        strokeWidth: 1,
            //      );
            //    }),
            child: CustomBottomSheet(
              type: widget.type,
              moviedetail: movieDetails,
              id: widget.snapshot.data[widget.id].id,
            ),
            // ),
            // ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FabButton(),
      // bottomNavigationBar: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     notchMargin: 5.0,
      //     child: BottomBar())
    );
  }
}
