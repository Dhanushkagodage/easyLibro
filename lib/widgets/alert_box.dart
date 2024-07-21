import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertBox extends StatefulWidget {
  final String title;
  final String content;
  final String approveText;
  final String cancelText;
  final IconData icon;
  final Color iconColor;
  final Function() onApprove;
  final Function() onCancel;

  const AlertBox({
    super.key,
    required this.title,
    required this.content,
    required this.approveText,
    required this.cancelText,
    required this.icon,
    required this.iconColor,
    required this.onApprove,
    required this.onCancel,
  });

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 10.h,
      ),
      actionsPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      title: Row(
        children: [
          Icon(
            widget.icon,
            color: widget.iconColor,
            size: 25.sp,
          ),
          SizedBox(width: 10.w),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
      content: Text(
        widget.content,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF080C27),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            widget.cancelText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            widget.onCancel();
          },
        ),
        TextButton(
          child: Text(
            widget.approveText,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            widget.onApprove();
          },
        ),
      ],
    );
  }
}
