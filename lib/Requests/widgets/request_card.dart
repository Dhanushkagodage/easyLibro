import 'package:easylibro_app/Requests/Api/request.dart';
import 'package:easylibro_app/Requests/Api/request_services.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestCard extends StatefulWidget {
  final Request request;
  final VoidCallback onRequestRemoved;

  const RequestCard({
    super.key,
    required this.request,
    required this.onRequestRemoved,
  });

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  RequestService requestService = RequestService();

  Color _containerColor = Colors.red;

  void _changeColorTemporarily() {
    setState(() {
      _containerColor = const Color.fromARGB(154, 244, 67, 54);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _containerColor = Colors.red;
      });
    });
  }

  void _showDeleteControl(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertBox(
          title: 'Remove Request:',
          content: 'Are you sure you want to remove this request?',
          icon: Icons.error_outline_rounded,
          iconColor: Colors.yellow,
          approveText: 'Yes',
          cancelText: 'No',
          onCancel: () {
            Navigator.of(context).reassemble();
          },
          onApprove: () async {
            Navigator.of(context).pop();
            try {
              await requestService.deleteRequest(widget.request.id);

              showDialog(
                context: parentContext,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Request Removed:',
                    content: 'Request removed successfully',
                    approveText: 'OK',
                    icon: Icons.check_circle_outline_rounded,
                    iconColor: Colors.green,
                    onApprove: () {
                      Navigator.of(context).pop();
                      widget.onRequestRemoved();
                    },
                  );
                },
              );
            } catch (e) {
              showDialog(
                context: parentContext,
                builder: (BuildContext context) {
                  return AlertBox(
                    title: 'Error:',
                    content: 'Failed to remove request',
                    approveText: 'OK',
                    icon: Icons.error_outline_rounded,
                    iconColor: Colors.red,
                    onApprove: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
        side: BorderSide(color: Colors.grey, width: 1.sp),
      ),
      borderOnForeground: true,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 20.w),
              child: Container(
                width: 40.sp,
                height: 40.sp,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Icon(
                  Icons.perm_contact_calendar_rounded,
                  color: Color(0xFF080C27),
                  size: 25.sp,
                ),
              ),
            ),
            Container(
              width: 150.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.request.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'ISBN: ${widget.request.isbn.toString()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Date: ${widget.request.date}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 80.sp,
              height: 34.sp,
              decoration: BoxDecoration(
                color:_containerColor,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    _showDeleteControl(context);
                    _changeColorTemporarily();
                  },
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return const Color.fromARGB(255, 24, 23, 23);
                        }
                        return null;
                      },
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 252, 252),
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
