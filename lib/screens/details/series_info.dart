import 'package:flutter/material.dart';
import 'package:moofies/widgets/tag.dart';

class SeriesInfo extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const SeriesInfo({Key key, this.snapshot}) : super(key: key);
  @override
  _SeriesInfoState createState() => _SeriesInfoState();
}

class _SeriesInfoState extends State<SeriesInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Tag(tagName: "Seasons:", data: widget.snapshot.data.seasons,),
          Tag(tagName: "Episodes:", data: widget.snapshot.data.episodes,),
          Tag(tagName: "Status:", data: widget.snapshot.data.status,),
        ],
      ),
    );
  }
}