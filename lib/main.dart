import 'package:easylibro_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      builder: (context, _) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "EasyLibro APP",
        home: SplashScreen(),
      ),
      designSize: const Size(412, 732)  
    );
  }
}
