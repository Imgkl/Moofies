import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moofies/screens/App/app.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(// Color for Android
statusBarColor: Colors.red
),);
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_) {
runApp(MyApp());
});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moofies',
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
        
        ),
        brightness: Brightness.light,
        canvasColor: Colors.white,
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
