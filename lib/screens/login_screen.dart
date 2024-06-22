import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:easylibro_app/widgets/media_query.dart';
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
                   height: SizeConfig.blockSizeVertical * 37,
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: const Color(0xFF0D4065),
                 height: SizeConfig.blockSizeVertical * 35,
                child: Center(
                    child: Image.asset(
                  "assets/librarylogoRW.png",
                  scale: 20,
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 32,
                left: SizeConfig.blockSizeHorizontal * 7,
                right: SizeConfig.blockSizeHorizontal * 7,),
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
                  SizedBox(height: SizeConfig.blockSizeVertical * 5 ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                color: Color(0xFF080C27),
                              ),
                            )),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                color: Color(0xFF080C27),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color(0xFF0D4065),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical *5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LayoutScreen(currentIndex: 0,)),
                          );
                        },
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 8,
                          width: SizeConfig.blockSizeHorizontal * 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF0D4065)),
                          child: const Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have account?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
