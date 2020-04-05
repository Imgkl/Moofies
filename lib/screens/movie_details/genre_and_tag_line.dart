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
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "${widget.snapshot.data.original_title}",
                style: TextStyle(color: Colors.black, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // widget.snapshot.data.tagLine.length > 0
          //     ? Text(
          //         "${widget.snapshot.data.tagLine}",
          //         style: TextStyle(color: Colors.black, fontSize: 17),
          //         textAlign: TextAlign.center,
          //       )
          //     : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: List.generate(
                  widget.snapshot.data.genre.length,
                  (i) {
                    return TextSpan(
                        text: " | ${widget.snapshot.data.genre[i]['name']} | " ,
                        
                        style: TextStyle(color: Colors.black, fontSize: 14));
                  },
                ),
                style: Theme.of(context).textTheme.caption,
              ),
                textAlign: TextAlign.center,

            ),
          ),
        ],
      ),
    );
  }
}
