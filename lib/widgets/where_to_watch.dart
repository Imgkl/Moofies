import 'package:flutter/material.dart';

class WhereToWatch extends StatefulWidget {
  final String path;
  final double scale;
  final bool notGeneric;

  const WhereToWatch(
      {Key key, this.path, this.scale = 2, this.notGeneric = true})
      : super(key: key);
  @override
  _WhereToWatchState createState() => _WhereToWatchState();
}

class _WhereToWatchState extends State<WhereToWatch> {
  bool notGeneric = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      notGeneric = widget.notGeneric;
    });
  }

  @override
  Widget build(BuildContext context) {
    return notGeneric
        ? OutlineButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            onPressed: null,
            child: Image.asset(
              "${widget.path}",
              scale: widget.scale,
            ))
        : OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)),
            onPressed: null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/home_page.png",
                height: 28,
                width: 28,
              ),
            ));
  }
}
