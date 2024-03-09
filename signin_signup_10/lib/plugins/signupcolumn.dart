// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_signup_10/screens/login_page.dart';
import 'package:signin_signup_10/screens/types_of_login_page.dart';
import '../services/auth_service.dart';

class MySignUpColumn extends StatefulWidget {
  const MySignUpColumn({super.key});

  @override
  State<MySignUpColumn> createState() => _MySignUpColumnState();
}

class _MySignUpColumnState extends State<MySignUpColumn> {
  final GlobalKey<FormState> _myKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Form(
            key: _myKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (email) {
                      if (!EmailValidator.validate(email!)) {
                        return 'Geçersiz bir e-mail adresi girildi.';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email_outlined,
                            color: Colors.grey, size: 30),
                        hintText: 'Lutfen geçerli bir e-mail adresi giriniz',
                        hintStyle: TextStyle(
                          color: Color(0xff281537),
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                          color: Color(0xffB81736),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (password) {
                      if (password!.length <= 5) {
                        return 'Lütfen 6 ve üzeri uzunlukta bir şifre giriniz';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true, //gizlensin
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock_clock_outlined,
                          color: Colors.grey, size: 30),
                      hintText: 'Lutfen sifrenizi giriniz',
                      hintStyle: TextStyle(
                        color: Color(0xff281537),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color(0xffB81736),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller:
                        _confirmController, // girilen text'i alır, ileride kullanmak için
                    validator: (confirmData) {
                      if (confirmData != _passwordController.text) {
                        return 'Girdiğiniz şifreler birbiriyle uyuşmuyor';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true, // gizle
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Color(0xffB81736),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      hintText: 'Şifreyi tekrar giriniz',
                      hintStyle: TextStyle(
                        color: Color(0xff281537),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      suffixIcon: Icon(
                        Icons.lock_person_outlined,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 300,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ],
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            onPressed: () async {
              if (_myKey.currentState!.validate()) {
                // düzgün bir email- password, confirm girilmişse, her şey true ise;
                final user = await Provider.of<Auth>(context, listen: false)
                    .createEmailAndPassword(
                        _emailController.text, _passwordController.text);
                // şuan firebase'de yeni kişi oluşturdu
                if (!user!.emailVerified) {
                  await user.sendEmailVerification();
                  // doğrulama e-maili gönder
                  // e-maile doğrulama maili gönder
                  await _controlFirstEmailAlertDialog();
                }
                // firebase üzerinden giriş yaptı olarak gözüktüğü için tekrar dışarı at
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Do you have already an account ?',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TypesLoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> _controlFirstEmailAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Onayla'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('E-mail Doğrulayınız'),
                Text(
                    'Lütfen devam etmeden önce e-mail kutunuzu kontrol ediniz ve mailinizi doğrulamamışsanız doğrulayınız. Aksi halde login sayfasında otomatik çıkış yapacaksınız.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
