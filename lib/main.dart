import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:iluv/screens/Home.dart';

bool isWeb = false;
int currentIndex = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    isWeb = true;
  } else {
    isWeb = false;
  }
  runApp(const Home());
}
