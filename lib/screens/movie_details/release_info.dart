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
    return widget.snapshot.data.runTime != null &&
            widget.snapshot.data.releaseDate != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  LineIcons.calendar,
                  color: Colors.white,
                ),
                Text(
                    " ${DateTime.parse(widget.snapshot.data.releaseDate).year}",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 20,
                ),
                Icon(
                  LineIcons.clock_o,
                  color: Colors.white,
                ),
                Text(" ${widget.snapshot.data.runTime} minutes",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          )
        : Container();
  }
}
