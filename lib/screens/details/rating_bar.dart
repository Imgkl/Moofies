import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';

class Rating extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const Rating({Key key, this.snapshot}) : super(key: key);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(LineIcons.star_o),
        Text("${widget.snapshot.data.rating}"),
      ],
    );
  }
}
