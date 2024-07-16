import 'package:flutter/material.dart';

class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar({super.key});

  @override
  State<CustomSnackBar> createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text("content"), action: SnackBarAction(label: "Action", onPressed: () {}));
  }
}
