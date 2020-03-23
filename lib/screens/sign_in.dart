import 'package:flutter/material.dart';
import 'package:moofies/auth/auth.dart';
import 'package:moofies/services/prefs.dart';


class Home extends StatelessWidget {
  final apptitle;

  const Home({Key key, this.apptitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apptitle),
      ),
      body: Center(
        child: RaisedButton(child: Text("Log out"), onPressed: (){
          signOutGoogle().whenComplete((){
          LocalStorage.setUserLoggedIn(false);
            Navigator.of(context).pop();
          });
        },)
      ),
    );
  }
}