import 'dart:async';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Login/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalUserName;

  @override
  void initState() {
    super.initState();
    _getValidationData().whenComplete(() async {
      Timer(const Duration(seconds: 10), () {
        if (finalUserName == null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LayoutScreen(currentIndex: 2)));
        }
      });
    });
  }

  Future<void> _getValidationData() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final obtainedUserName = localStorage.getString('userName');
    final accessToken = localStorage.getString('accessToken');

    print("accessToken:$accessToken");
    print("username:$obtainedUserName");
    setState(() {
      finalUserName = obtainedUserName;
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
            scale: 32,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFF0D4065),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Text(
                "From:",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontFamily: "AlternateGotNo3D",
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Chico_Coders",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontFamily: "AlternateGotNo3D",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
