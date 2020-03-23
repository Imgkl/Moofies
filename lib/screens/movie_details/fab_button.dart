import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FabButton extends StatefulWidget {
  @override
  _FabButtonState createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.07,
      width: screenWidth * 0.14,
      child: FittedBox(
        child: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(
              LineIcons.youtube_play,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
    );
  }
}
