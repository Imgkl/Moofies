import 'package:flutter/material.dart';

class GenreTagLine extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const GenreTagLine({Key key, this.snapshot}) : super(key: key);
  @override
  _GenreTagLineState createState() => _GenreTagLineState();
}

class _GenreTagLineState extends State<GenreTagLine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.snapshot.data.tagLine.length > 0
            ? Text(
                "${widget.snapshot.data.tagLine}",
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              children: List.generate(
                widget.snapshot.data.genre.length,
                (i) {
                  return TextSpan(
                      text: " | ${widget.snapshot.data.genre[i]['name']} | ",
                      style: TextStyle(color: Colors.white, fontSize: 14));
                },
              ),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      ],
    );
  }
}
