import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moofies/screens/App/app.dart';
import 'package:moofies/screens/movie_details/movie_details.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moofies',
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.ubuntuTextTheme(
      Theme.of(context).textTheme,
    ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool userLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return App();
  }
}
