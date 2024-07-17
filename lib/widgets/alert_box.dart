import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertBox extends StatefulWidget {
  final String? title;
  final String content;
  final String approveText;
  final String? cancelText;
  final IconData? icon;
  final Color? iconColor;
  final Function() onApprove;
  final Function()? onCancel;

  const AlertBox({
    super.key,
    this.title,
    required this.content,
    required this.approveText,
    this.cancelText,
    this.icon,
    this.iconColor,
    required this.onApprove,
    this.onCancel,
  });

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //   title: Padding(
    //     padding:  EdgeInsets.only(top: 5.h),
    //     child: widget.title != null ? Text(widget.title!) : null,
    //   ),
    //   content: SingleChildScrollView(
    //     child: ListBody(
    //       children: <Widget>[
    //         Center(child: Text(widget.content)),
    //       ],
    //     ),
    //   ),
    //   actions: <Widget>[
    //     if (widget.cancelText == null)
    //       Center(
    //           child: Icon(
    //         widget.icon,
    //         color: widget.iconColor,
    //         size: 60.sp,
    //       )),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         if (widget.cancelText != null)
    //           TextButton(
    //             child: Text(widget.cancelText!),
    //             onPressed: () {
    //               widget.onCancel!();
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         TextButton(
    //           child: Text(widget.approveText),
    //           onPressed: () {
    //             widget.onApprove();
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ], // Align buttons to the right
    //     ),
    //   ],
    // );
    return AlertDialog(
       
      title: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: widget.title != null
            ? Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )
            : null,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.content,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          if (widget.icon != null)
            Icon(
              widget.icon,
              color: widget.iconColor,
              size: 60.sp,
            ),
        ],
      ),
      actions: [
        if (widget.cancelText != null)
          TextButton(
            child: Text(
              widget.cancelText!,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              widget.onCancel!();
              Navigator.of(context).pop();
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
           // Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
