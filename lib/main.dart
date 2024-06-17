import 'package:easylibro_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easylibro_app/widgets/theme_data_style.dart';
import 'package:easylibro_app/widgets/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EasyLibro APP",
      theme: ThemeDataStyle.light, // Light/Default mode styles
      darkTheme: ThemeDataStyle.dark,
      home: SplashScreen(),
    );
  }
}
