import 'package:easylibro_app/Requests/Api/my_requests.dart';
import 'package:easylibro_app/Requests/Api/request.dart';
import 'package:easylibro_app/Requests/widgets/request_card.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/cupertino.dart';
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

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
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
      _showErrorSnackbar('Failed to Load requests');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchRequests();
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
                  fontSize: 15.sp,
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
                          child: RefreshIndicator(
                            onRefresh: _handleRefresh,
                            color: Color(0xFF080C27),
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.sp),
                              child: requests.isEmpty
                                  ? Center(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.tray,
                                              size: 50.sp,
                                              color: Color.fromARGB(
                                                  255, 175, 175, 175),
                                            ),
                                            Text(
                                              'No Requests',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontFamily: 'Inter',
                                                color: Color.fromARGB(
                                                    255, 175, 175, 175),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : _buildRequests(),
                            ),
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
