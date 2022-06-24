import 'dart:async';

import 'package:dekoki/common/style.dart';
import 'package:dekoki/widget/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BotNavBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorStyles.secondaryColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/icons/logo-dekoki-transparent.png",
              width: 120,
              height: 120,
            ),
            Text(
              'dekoki',
              style: GoogleFonts.fredokaOne(
                fontSize: 32,
                color: ColorStyles.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
