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
                    bottom: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            child: CustomBottomSheet(
              type: widget.type,
              moviedetail: movieDetails,
              id: widget.snapshot.data[widget.id].id,
            ),
          ),
        ],
      ),
    );
  }
}
