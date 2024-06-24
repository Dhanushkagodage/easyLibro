import 'package:easylibro_app/Login/login_screen.dart';
import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/screens/splash_screen.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EasyLibro APP",
      //home: SplashScreen(),
       home: LoginScreen(),
     // home: LayoutScreen(currentIndex: 0,),
    );
  }
}
