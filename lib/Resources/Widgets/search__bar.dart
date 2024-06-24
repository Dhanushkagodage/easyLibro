import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class Search_Bar extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final double width;
  final bool enable;

  const Search_Bar({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    required this.width,
    required this.enable,
  });

  @override
  State<Search_Bar> createState() => _Search_BarState();
}

// ignore: camel_case_types
class _Search_BarState extends State<Search_Bar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      enabled: widget.enable,
      controller: widget.controller,
      onChanged: widget.onChanged,
      constraints: BoxConstraints(
        minHeight: 40,
        maxWidth: widget.width,
      ),
      leading: const Icon(Icons.search_outlined, color: Color(0xFF080C27)),
      hintText: widget.hintText,
      hintStyle: WidgetStatePropertyAll<TextStyle?>(
        TextStyle(
          fontFamily: "Inter",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF080C27),
        ),
      ),
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      shadowColor: WidgetStateProperty.all(
        Color.fromARGB(255, 49, 48, 52).withOpacity(0.9),
      ),
      side: WidgetStateProperty.all(
        BorderSide(
          color: Color(0xFF080C27).withOpacity(0.9),
          width: 0.7,
        ),
      ),
      elevation: WidgetStateProperty.all(2),
    );
  }
}
