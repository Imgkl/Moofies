import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moofies/auth/auth_landing.dart';
import 'package:moofies/screens/App/app.dart';
import 'package:moofies/services/prefs.dart';
import 'package:wiredash/wiredash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    LocalStorage.initilize().then((value) => runApp(MyApp()));
  });
}

class MyTranslations extends WiredashTranslationData {
  String get feedbackStateIntroMsg =>
      'I can’t wait to get your thoughts on my app. What would you like to do?';
  String get feedbackModePraiseMsg =>
      'Let me know what you really like about our app, maybe I can make it even better?';
  String get feedbackStateFeedbackMsg =>
      'I am listening. Please provide as much info as needed so I can help you.';
  String get feedbackModeImprovementMsg =>
      'Do you have an idea that would make our app better? I would love to know!';
  String get feedbackModeBugMsg =>
      'Let me know so I can forward this to our bug control, which is me. 😉';
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
