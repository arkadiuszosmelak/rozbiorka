import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rozbiorka/screens/home_screen.dart';
import 'package:rozbiorka/screens/auth_screen.dart';
import 'package:rozbiorka/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.indigo,
            backgroundColor: Colors.indigoAccent[100],
            accentColor: Colors.grey[300],
            accentColorBrightness: Brightness.dark,
            fontFamily: 'OpenSans',
            textTheme: TextTheme(
              headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              headline5: TextStyle(color: Colors.white, fontSize: 15),
              headline6: TextStyle(fontSize: 14, color: Colors.white),
            ),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.white,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            highlightColor: Colors.indigo,
          ),
          home: appSnapshot.connectionState != ConnectionState.done
              ? SplashScreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (userSnapshot.hasData) {
                      return HomeScreen();
                    }
                    return AuthScreen();
                  }),
        );
      },
    );
  }
}
