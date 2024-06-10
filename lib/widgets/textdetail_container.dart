import 'package:flutter/material.dart';

class TextdetailContainer extends StatefulWidget {
  final String label;
  final String value;

  const TextdetailContainer({super.key,
    required this.label,
    required this.value,});

  @override
  State<TextdetailContainer> createState() => _TextdetailContainerState();
}

class _TextdetailContainerState extends State<TextdetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.label} : ", 
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D4065))),
        Text(widget.value,
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6A6A6A)),),
      ],
    );
  }
}
