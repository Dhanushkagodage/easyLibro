import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.label} : ", 
               
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D4065))),
        Flexible(
          fit: FlexFit.loose,
          child: Text(widget.value,
              
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6A6A6A)),),
        ),
      ],
    );
  }
}
