import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final tagName;
  final data;

  const Tag({Key key, this.tagName, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: null,
      child: Row(
        children: <Widget>[
          Text("$tagName"),
           Text(" $data")
        ],
      ),
    );
  }
}