import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  final String? title;
  final String content;
  final String approveText;
  final String? cancelText;
  final Function() onApprove;
  final Function() onCancel;

  AlertBox({
    super.key,
    this.title,
    required this.content,
    required this.approveText,
    this.cancelText,
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
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: widget.title != null ? Text(widget.title!) : null,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(widget.content),
          ],
        ),
      ),
      actions: <Widget>[
        if (widget.cancelText == null)
          Center(
              child: Icon( 
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.cancelText != null)
              TextButton(
                child: Text(widget.cancelText!),
                onPressed: () {
                  widget.onCancel();
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(widget.approveText),
              onPressed: () {
                widget.onApprove();
                Navigator.of(context).pop();
              },
            ),
          ], // Align buttons to the right
        ),
      ],
    );
  }
}
