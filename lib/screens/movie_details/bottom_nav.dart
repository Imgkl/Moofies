import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Icon(LineIcons.plus)),
          Align(
            alignment: Alignment.bottomCenter,
             child: Container(
              height: screenHeight * 0.02,
              child: VerticalDivider(
              thickness: 1,
              color: Colors.black,
            ),
            ),
          ),
          Expanded(child: Icon(LineIcons.check))
        ],
      ),
    );
  }
}
