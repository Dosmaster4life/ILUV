import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:iluv/screens/loginChecker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

bool isWeb = false;
int currentIndex = 0;
bool loggedIn = false;
bool kioskMode = false;

getLoggedInStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool('isLoggedIn');

  return boolValue;
}
getKiosk() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? kioskMode = prefs.getBool('isKiosk');
    return kioskMode;
  }catch(e) {
    return false;
  }

}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  loggedIn = await getLoggedInStatus() ?? false;
  kioskMode = await getKiosk() ?? false;
  debugPrint(loggedIn.toString());
  debugShowCheckedModeBanner:false;

  if (kIsWeb) {
    isWeb = true;
  } else {
    isWeb = false;
  }
  runApp(const loginChecker());
}
