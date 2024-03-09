// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_signup_10/screens/login_page.dart';
import 'package:signin_signup_10/screens/welcome_page.dart';
import 'package:signin_signup_10/services/auth_service.dart';
import 'package:signin_signup_10/services/onboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAT8xLyDS9gjQ5oPY9tqFd_dH3XY9Bl26A",
        appId: "1:129767293539:android:473106c086a1a86d536e56",
        messagingSenderId: '129767293539',
        projectId: "auth-secondary-example"),
  );
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create:  (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: OnBoardWidget(),
      ),
    );
  }
}
