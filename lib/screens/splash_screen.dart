// import 'dart:async';
// import 'package:easylibro_app/widgets/layout_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/Login/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {

//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   String? finalUserName;

//   @override
//   void initState() {
//     super.initState();
//     getValidationData().whenComplete(() async {
//       Timer(const Duration(seconds: 3), () {
//         if (finalUserName == null) {
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) => const LoginScreen()));
//         } else {
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) => LayoutScreen(currentIndex: 2)));
//         }
//       });
//     });
//   }

//   Future <void>getValidationData() async {
//     final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
//     final obtainedUserName = sharedPreferences.getString('userName');

//     setState(() {
//       finalUserName = obtainedUserName;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFF0D4065),
//         body: Center(
//           child: Image.asset(
//             "assets/librarylogo.png",
//             scale: 30,
//           ),
//         ),
//         bottomNavigationBar: const Text("Powered By:@Chico_coders",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 13,
//                 color: Color.fromARGB(255, 4, 206, 246),
//                 fontFamily: "Inter",
//                 fontWeight: FontWeight.w500)),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Login/login_screen.dart';
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
      Timer(const Duration(seconds: 3), () {
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
    print(accessToken);
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
