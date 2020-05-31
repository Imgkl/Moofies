import 'package:wiredash/wiredash.dart';

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