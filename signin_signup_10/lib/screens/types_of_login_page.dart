// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:signin_signup_10/screens/login_page.dart';
import 'package:signin_signup_10/services/onboard.dart';
import '../services/auth_service.dart';

class TypesLoginPage extends StatelessWidget {
  const TypesLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffB81736),
            Color(0xff281537),
          ]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Lottie.asset('assets/typesoflottie.json'),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white54.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () async {
                    await Provider.of<Auth>(context, listen: false)
                        .signInAnonymously();
                    Navigator.pop(context);
                    // bu sayfayı kaldırdığında onboard sayfası kalır, orada da hangi
                    // sayfaya geçileceği yönlendirilir. O yüzden bu sayfayı kaldırmak şart
                  },
                  child: Text(
                    'Sign In Anonymously',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white54.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Sign In with Email & Password',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white54.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false)
                          .signInWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnBoardWidget(), // buradan yönlendirme yapalım diye
                          // eğer giriş yapabilmişsek OnBoard katmanı bizi HomePage'e, değilse WelcomePage'e atar
                        ),
                      );
                    },
                    child: Text(
                      'Sign In with Google',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
