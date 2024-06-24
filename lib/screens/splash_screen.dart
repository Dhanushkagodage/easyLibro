import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 20), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D4065),
        body: Center(
          child: Image.asset(
            "assets/librarylogo.png",
            scale: 30,
          ),
        ),
        bottomNavigationBar: const Text("Powered By:@Chico_coders",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 4, 206, 246),
                fontFamily: "Inter",
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
