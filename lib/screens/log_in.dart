import 'package:flutter/material.dart';
import 'package:moofies/auth/auth.dart';
import 'package:moofies/screens/sign_in.dart';
import 'package:moofies/services/prefs.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Google Sign In"),
          onPressed: () {
            signInWithGoogle().whenComplete((){
              LocalStorage.setUserLoggedIn(true);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Home(apptitle: "Moofies")));
            });
          },
        ),
      ),
    );
  }
}