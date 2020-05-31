import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/auth/auth.dart';
import 'package:moofies/screens/App/app.dart';
import 'package:moofies/services/prefs.dart';
import 'package:shimmer/shimmer.dart';

class AuthLanding extends StatefulWidget {
  @override
  _AuthLandingState createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0, left: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                child: Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.white,
                  child: DragTarget(
                    builder:
                        (context, List<String> candidateData, rejectedData) {
                      return Platform.isIOS
                          ? Icon(
                              FontAwesomeIcons.apple,
                              size: 30,
                            )
                          : Icon(
                              FontAwesomeIcons.facebookF,
                              size: 30,
                            );
                    },
                    onAccept: (data) {
                      print("apple");
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 70.0,
            ),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Draggable<String>(
                  data: "👆🏻",
                  childWhenDragging: Text(
                    "Choose the login method",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Text(
                      "👆🏻",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 100,
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0, right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.white,
                child: DragTarget(
                  builder: (BuildContext context, List<String> incoming, List rejected) {
                    return Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.google,
                        size: 30,
                      ),
                    );
                  },
                  onWillAccept: (data) => data == '👆🏻',
                  onAccept: (data) {
                    signInWithGoogle().then((data) {
                      setState(() {
                        LocalStorage.setUserLoggedIn(true);
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/app', (Route<dynamic> route) => false);
                    }).catchError((e) {
                      print(e);setState(() {
                        LocalStorage.setUserLoggedIn(false);
                      });
                    });
                    // signOutGoogle();
                  },
                  // onAccept: (data) {
                  //   print("Google");
                  // },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
