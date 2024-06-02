import 'package:flutter/material.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: const Color(0xFF0D4065),
                  height: 250,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0xFF0D4065),
                height: 242,
                child: Center(
                    child: Image.asset(
                  "assets/librarylogoRW.png",
                  scale: 3,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210, left: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sign in",
                      style: TextStyle(
                          fontSize: 38,
                          color: Color(0xFF080C27),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600)),
                  const Text("Welcome!",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF080C27),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height:45
                  ),
                  Container(
                      height: 63,
                      width: 353,
                      child: const Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          Text("Email",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF080C27),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500)),
                          
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
