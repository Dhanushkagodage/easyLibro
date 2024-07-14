import 'package:easylibro_app/Requests/Api/my_requests.dart';
import 'package:easylibro_app/Requests/Api/request.dart';
import 'package:easylibro_app/Requests/widgets/request_card.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestScreen extends StatefulWidget {
  final VoidCallback fetchunreadcount;
  const RequestScreen({super.key, required this.fetchunreadcount});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isLoading = true;
  bool hasError = false;
  final MyRequests _myRequests = MyRequests();
  List<Request> requests = [];

  @override
  void initState() {
    super.initState();
    _fetchRequests();
    widget.fetchunreadcount();
  }

  Future<void> _fetchRequests() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      await _myRequests.fetchRequests();
      setState(() {
        requests = _myRequests.allRequests;
      });
      requests.sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
      });
      showDialog(
          context: context,
          builder: (context) => AlertBox(
                content: "Failed to load resources",
                approveText: "OK",
                icon: Icons.error,
                iconColor: Colors.red,
                onApprove: () {
                  Navigator.of(context).pop();
                },
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: Padding(
          padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Requests:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  color: Color(0xFF080C27),
                  fontWeight: FontWeight.w600,
                ),
              ),
              isLoading
                  ? Expanded(child: MyLoadingIndicator())
                  : hasError
                      ? Expanded(
                          child: ErrorScreen(),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.sp),
                            child: _buildRequests(),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequests() {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return RequestCard(
          request: request,
          onRequestRemoved: _fetchRequests,
        );
      },
    );
  }
}
