import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:iluv/screens/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:iluv/screens/loginChecker.dart';
import 'firebase_options.dart';
bool isWeb = false;
int currentIndex = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    isWeb = true;
  } else {
    isWeb = false;
  }
  runApp(const loginChecker());
}
