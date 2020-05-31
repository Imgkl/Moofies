import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moofies/auth/auth.dart';
import 'package:moofies/auth/auth_landing.dart';
import 'package:moofies/services/prefs.dart';
import 'package:wiredash/wiredash.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Icon(
                LineIcons.question_circle,
                color: Colors.black,
              ),
              onTap: () {
                Wiredash.of(context).show();
              },
            ),
          )
        ],
      ),
      body: Center(
          child: RaisedButton(
        child: Text("Log Out"),
        onPressed: () {
          setState(() {
             LocalStorage.setUserLoggedIn(false);
          });
          signOut().whenComplete(() {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/auth', (Route<dynamic> route) => false);
          });
        },
      )),
    );
  }
}
