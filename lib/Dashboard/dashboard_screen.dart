import 'dart:async';
import 'package:easylibro_app/Dashboard/dashboard_service.dart';
import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/Widgets/resource_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback fetchunreadcount;
  const DashboardScreen({
    super.key,
    required this.fetchunreadcount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;
  late Timer _timer;
  final double scrollAmount = 115.w;
  bool isLoading = true;
  List<Resource> resources = [];
  MyResources myResources = MyResources();
  DashboardService dashboardService = DashboardService();
  final MyReviews myReviews = MyReviews();
  String status = "";
  String myReservations = "";
  String myRequests = "";
  String penalty = "";
  List<String> annoucement = [];
  bool isFetchingAnnouncements = true;

  static List<Resource>? cachedResources;

  int _currentIndex = 0;

  void _nextAnnouncement() {
    setState(() {
      if (_currentIndex < annoucement.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _previousAnnouncement() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  Future<void> fetchAnnouncement() async {
    try {
      setState(() {
        isFetchingAnnouncements = true;
      });
      final data = await dashboardService.fetchAnnoucement();
      setState(() {
        annoucement = data;
        isFetchingAnnouncements = false;
      });
      print("annoucement:$annoucement");
    } catch (e) {
      setState(() {
        isFetchingAnnouncements = false;
      });
      _showErrorSnackbar('Failed to Load Announcements');
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cachedResources == null) {
        _fetchResources();
      } else {
        setState(() {
          resources = cachedResources!;
          isLoading = false;
        });
        startAutoScroll();
      }
    });
    fetchDashboardData();
    fetchAnnouncement();
    widget.fetchunreadcount();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<double> fetchRating(String isbn) async {
    return await myReviews.fetchRating(isbn);
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

  void startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients && resources.isNotEmpty) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentScrollPosition = _scrollController.position.pixels;

        if (currentScrollPosition < maxScrollExtent) {
          _scrollController.animateTo(
            currentScrollPosition + scrollAmount,
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  Future<void> _fetchResources() async {
    setState(() {
      isLoading = true;
    });
    await myResources.fetchResources("", "all", "all");
    setState(() {
      resources = myResources.getAllResourcesByCategory('All');
      cachedResources = resources;
      isLoading = false;
    });
    if (resources.isNotEmpty) {
      startAutoScroll();
    }
  }

  Future<void> fetchDashboardData() async {
    try {
      final data = await dashboardService.fetchDashboardData();

      setState(() {
        status = data['status'];
        myReservations = data['myReservations'].toString();
        myRequests = data['requests'].toString();
        penalty = data['penalty'].toString();
      });
    } catch (e) {
      _showErrorSnackbar('Failed to Load dashboard data');
    }
  }

  Future<void> _handleRefresh() async {
    await _fetchResources();
    await fetchDashboardData();
    await fetchAnnouncement();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: Color(0xFF080C27),
        backgroundColor: Colors.white,
        child: Container(
          color: const Color(0xFFF7F8FD),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    left: width * 0.06,
                    right: width * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👋 Hello",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Inter',
                          color: Color(0xFF080C27),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Welcome to the easyLIBRO",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                          color: Color(0xFF080C27),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 15.h,
                    top: 15.h,
                  ),
                  child: Container(
                    height: 130.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.sp),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40.h,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.sp,
                                right: 10.sp,
                                top: 10.sp,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "📢 Announcements",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontFamily: 'Inter',
                                      color: Color(0xFF080C27),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 84.h,
                          // color: Colors.blue,
                          child: isFetchingAnnouncements
                              ? Padding(
                                  padding: EdgeInsets.only(top: 10.sp),
                                  child: Center(
                                      child: MyLoadingIndicator(
                                    size: 20.sp,
                                  )),
                                )
                              : annoucement.isNotEmpty
                                  ? Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 84.sp,
                                            width: 24.sp,
                                            child: Center(
                                              child: IconButton(
                                                  onPressed:
                                                      _previousAnnouncement,
                                                  icon: Icon(
                                                    CupertinoIcons.back,
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            child: Card(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.sp),
                                              ),
                                              shadowColor: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              child: Container(
                                                height: 84.sp,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.sp, right: 5.sp),
                                                  child: Text(
                                                    annoucement[_currentIndex],
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontFamily: 'Inter',
                                                      color: Color(0xFF080C27),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 84.sp,
                                            width: 24.sp,
                                            child: Center(
                                              child: IconButton(
                                                  onPressed: _nextAnnouncement,
                                                  icon: Icon(
                                                    CupertinoIcons.forward,
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.tray,
                                              size: 35.sp,
                                              color: Color.fromARGB(
                                                  255, 175, 175, 175),
                                            ),
                                            Text(
                                              'No Announcements Available',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontFamily: 'Inter',
                                                color: Color.fromARGB(
                                                    255, 175, 175, 175),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LayoutScreen(currentIndex: 0)),
                      );
                    },
                    child: Container(
                      height: 45.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.sp),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.sp),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.search_sharp,
                            color: Colors.grey,
                            size: 28.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Tap to Search more Resources",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Inter',
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.sp),
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Container(
                      decoration: BoxDecoration(),
                      height: 230.h,
                      width: double.infinity,
                      child: isLoading
                          ? Padding(
                              padding: EdgeInsets.only(top: 20.sp),
                              child: Center(
                                  child: MyLoadingIndicator(
                                size: 30.sp,
                              )),
                            )
                          : GridView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: (200 / 100),
                              ),
                              itemCount: resources.length,
                              itemBuilder: (context, index) {
                                final resource = resources[index];
                                return ResourceCard(
                                    resource: resource,
                                    fetchRating: () =>
                                        fetchRating(resource.isbn));
                              },
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Stats:',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Inter',
                          color: Color(0xFF080C27),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.sp),
                          color: const Color(0xFFF7F8FD),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: Column(
                            children: [
                              TileContainer("Status", status,
                                  Icons.warning_amber_rounded),
                              SizedBox(height: 20.h),
                              TileContainer("My Reservations", myReservations,
                                  Icons.double_arrow),
                              SizedBox(height: 20.h),
                              TileContainer("My Requests", myRequests,
                                  Icons.perm_contact_calendar_rounded),
                              SizedBox(height: 20.h),
                              TileContainer("Penalty", penalty,
                                  Icons.trending_down_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TileContainer(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.sp),
        color: Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(10.sp),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
              child: Icon(
                icon,
                color: Color(0xFF080C27),
                size: 35,
              ),
            ),
            SizedBox(width: 30.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'Inter',
                    color: const Color(0xFF080C27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontFamily: 'Inter',
                    color: const Color(0xFF080C27),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
