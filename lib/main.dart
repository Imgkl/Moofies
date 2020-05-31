import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moofies/auth/auth_landing.dart';
import 'package:moofies/screens/App/app.dart';
import 'package:moofies/services/prefs.dart';
import 'package:moofies/widgets/wiredash_translations.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    LocalStorage.initilize().then((value) => runApp(MyApp()));
  });
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "moofies-x50s179",
      secret: "nyuczm0g4950vj103p1gbi8mspi5acpa",
      navigatorKey: _navigatorKey,
      options: WiredashOptionsData(
        showDebugFloatingEntryPoint: false,
      ),
      translation: MyTranslations(),
      theme: WiredashThemeData(brightness: Brightness.dark),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
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
        routes: {
                    "/app": (_) => App(),
                    "/auth": (_) => AuthLanding(),
                  },
      ),
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
  void initState() {
    super.initState();
    setState(() {
      userLoggedIn = LocalStorage.getUserLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return userLoggedIn? App(): AuthLanding();
  }
}
