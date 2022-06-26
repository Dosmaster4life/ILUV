import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:iluv/screens/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iluv/screens/loginChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
bool isWeb = false;
int currentIndex = 0;
bool loggedIn = false;
getLoggedInStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool('isLoggedIn');
  return boolValue;
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  loggedIn = await getLoggedInStatus() ?? false;
  debugPrint(loggedIn.toString());

  if (kIsWeb) {
    isWeb = true;
  } else {
    isWeb = false;
  }
  runApp(const loginChecker());
}
