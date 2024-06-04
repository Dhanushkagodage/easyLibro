import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class Search_Bar extends StatefulWidget {
  
  String? hintText;
  ValueChanged<String>? onChanged;  

  Search_Bar(
      {super.key,
      required this.hintText,
      this.onChanged,
  });

  @override
  State<Search_Bar> createState() => _Search_BarState();
}

// ignore: camel_case_types
class _Search_BarState extends State<Search_Bar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      constraints: const BoxConstraints(
      minHeight: 50,
      maxWidth:280, 
    ),
      leading: const Icon(Icons.search_outlined),
      hintText: widget.hintText,
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      shape: WidgetStateProperty.all(const ContinuousRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),     
    )),
    elevation: WidgetStateProperty.all(2),
    );
  }
}
