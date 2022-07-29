import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'main_scaffold.dart';
import 'styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {

  Future<bool> checkAccountStatus() async {
    //Connect to firebase Auth.
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slow Your Roll',
      theme: lightTextThemeData,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: checkAccountStatus(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return const SignUpScreen();
            } else if (snapshot.data == true) {
              return const MainScaffold();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              //Show loading widget
              return const RiverpodLoading();
            } else {
              //Show error widget
              return const RiverpodError(screenName: 'Main Scaffold');
            }
          }
      ),
    );
  }
}