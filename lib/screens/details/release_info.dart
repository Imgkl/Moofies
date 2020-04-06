import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ReleaseInfo extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const ReleaseInfo({Key key, this.snapshot}) : super(key: key);
  @override
  _ReleaseInfoState createState() => _ReleaseInfoState();
}

class _ReleaseInfoState extends State<ReleaseInfo> {
  @override
  Widget build(BuildContext context) {
    return 
            widget.snapshot.data.releaseDate != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  LineIcons.calendar,
                  color: Colors.black,
                ),
                Text(
                    widget.snapshot.data.releaseDate != " " ? "${DateTime.parse(widget.snapshot.data.releaseDate).year}" : "NA",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 20,
                ),
              widget.snapshot.data.runTime !=null?  Row(
                  children: <Widget>[
                    Icon(
                  LineIcons.clock_o,
                  color: Colors.black,
                ),
                Text(" ${widget.snapshot.data.runTime} minutes",
                    style: TextStyle(
                      color: Colors.black,
                    )),
                  ],
                ): Container()
              ],
            ),
          )
        : Container();
  }
}
