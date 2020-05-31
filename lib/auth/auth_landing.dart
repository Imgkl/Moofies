import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
                child: DragTarget(
                  builder: (context, List<String> candidateData, rejectedData) {
                    return Platform.isIOS
                        ? NeumorphicButton(
                            isEnabled: false,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(90))),
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.concave,
                                depth: 100,
                                lightSource: LightSource.topLeft,
                                color: Colors.grey),
                            child: Shimmer.fromColors(
                              child: Icon(
                                FontAwesomeIcons.apple,
                                size: 30,
                              ),
                              baseColor: Colors.black,
                              highlightColor: Colors.white,
                            ))
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
                  child: NeumorphicText(
                    "Sign in",
                    textStyle: NeumorphicTextStyle(
                      fontSize: 30,
                    ),
                    style: NeumorphicStyle(
                      color: Colors.black,
                      depth: 3
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0, right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: DragTarget(
                builder: (BuildContext context, List<String> incoming,
                    List rejected) {
                  return NeumorphicButton(
                    onPressed: () {
                      signInUsingGoogle();
                    },
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(90))),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        depth: 100,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey),
                    child: Shimmer.fromColors(
                      baseColor: Colors.black,
                      highlightColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.google,
                        size: 27,
                      ),
                    ),
                  );
                },
                onWillAccept: (data) => data == '👆🏻',
                onAccept: (data) {
                  signInUsingGoogle();
                  // signOutGoogle();
                },
                // onAccept: (data) {
                //   print("Google");
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }

  signInUsingGoogle() {
    signInWithGoogle().then((data) {
      setState(() {
        LocalStorage.setUserLoggedIn(true);
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false);
    }).catchError((e) {
      print(e);
      setState(() {
        LocalStorage.setUserLoggedIn(false);
      });
    });
  }
}
