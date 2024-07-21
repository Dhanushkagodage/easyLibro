// import 'dart:async';
// import 'package:easylibro_app/Dashboard/dashboard_service.dart';
// import 'package:easylibro_app/Review/API/review.dart';
// import 'package:easylibro_app/widgets/loading_indictor.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
// import 'package:easylibro_app/widgets/layout_screen.dart';
// import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
// import 'package:easylibro_app/Resources/API/Models/resource.dart';
// import 'package:easylibro_app/Resources/Widgets/resource_card.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DashboardScreen extends StatefulWidget {
//   final VoidCallback fetchunreadcount;
//   const DashboardScreen({
//     super.key,
//     required this.fetchunreadcount,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   late ScrollController _scrollController;
//   late Timer _timer;
//   final double scrollAmount = 115.w;
//   bool isLoading = true;
//   List<Resource> resources = [];
//   MyResources myResources = MyResources();
//   DashboardService dashboardService = DashboardService();
//   final MyReviews myReviews = MyReviews();
//   String status = "";
//   String myReservations = "";
//   String myRequests = "";
//   String penalty = "";
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchResources();
//     });
//     fetchDashboardData();
//     widget.fetchunreadcount();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<double> fetchRating(String isbn) async {
//     return await myReviews.fetchRating(isbn);
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.error_outline,
//               color: Colors.white,
//             ),
//             SizedBox(width: 10.w),
//             Flexible(
//               fit: FlexFit.loose,
//               child: Text(
//                 message,
//                 style: TextStyle(
//                   fontFamily: "Inter",
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       if (_scrollController.hasClients && resources.isNotEmpty) {
//         double maxScrollExtent = _scrollController.position.maxScrollExtent;
//         double currentScrollPosition = _scrollController.position.pixels;

//         if (currentScrollPosition < maxScrollExtent) {
//           _scrollController.animateTo(
//             currentScrollPosition + scrollAmount,
//             duration: Duration(seconds: 1),
//             curve: Curves.easeInOut,
//           );
//         } else {
//           _scrollController.jumpTo(0); // Reset scroll position to start
//         }
//       }
//     });
//   }

//   Future<void> _fetchResources() async {
//     setState(() {
//       isLoading = true;
//     });
//     await myResources.fetchResources("", "all", "all");
//     setState(() {
//       resources = myResources.getAllResourcesByCategory('All');
//       isLoading = false;
//     });
//     if (resources.isNotEmpty) {
//       startAutoScroll();
//     }
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       final data = await dashboardService.fetchDashboardData();
//       setState(() {
//         status = data['status'];
//         myReservations = data['myReservations'].toString();
//         myRequests = data['requests'].toString();
//         penalty = data['penalty'].toString();
//       });
//     } catch (e) {
//       _showErrorSnackbar('Failed to Load dashboard data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         color: const Color(0xFFF7F8FD),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                   left: width * 0.06,
//                   right: width * 0.06,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "👋Hello ",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontFamily: 'Inter',
//                         color: Color(0xFF080C27),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       "Welcome to the easyLIBRO",
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontFamily: 'Inter',
//                         color: Color(0xFF080C27),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => LayoutScreen(currentIndex: 0)),
//                     );
//                   },
//                   child: Search_Bar(
//                     hintText: "Tap to Search more Resources",
//                     controller: null,
//                     enable: false,
//                     width: double.infinity,
//                   ),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey, width: 1.sp
//                   ),
//                   color: const Color.fromARGB(255, 229, 229, 229),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(20.sp),
//                   child: Container(
//                     decoration: BoxDecoration(),
//                     height: 230.h,
//                     width: double.infinity,
//                     child: isLoading
//                         ? Center(child: MyLoadingIndicator())
//                         : GridView.builder(
//                             controller: _scrollController,
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 1,
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                               childAspectRatio: (200 / 100),
//                             ),
//                             itemCount: resources.length,
//                             itemBuilder: (context, index) {
//                               final resource = resources[index];
//                               return ResourceCard(
//                                   resource: resource,
//                                   fetchRating: () =>
//                                       fetchRating(resource.isbn));
//                             },
//                           ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.sp),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'My Stats:',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontFamily: 'Inter',
//                         color: Color(0xFF080C27),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Colors.grey, width: 1.sp),
//                         color: const Color(0xFFF7F8FD),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(20.sp),
//                         child: Column(
//                           children: [
//                             TileContainer(
//                                 "Status", status, Icons.warning_amber_rounded),
//                             SizedBox(height: 20.h),
//                             TileContainer("My Reservations", myReservations,
//                                 Icons.double_arrow),
//                             SizedBox(height: 20.h),
//                             TileContainer("My Requests", myRequests,
//                                 Icons.perm_contact_calendar_rounded),
//                             SizedBox(height: 20.h),
//                             TileContainer("Penalty", penalty,
//                                 Icons.trending_down_rounded),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ignore: non_constant_identifier_names
//   Widget TileContainer(String title, String value, IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey, width: 1.sp),
//         color: Color(0xFFF7F8FD),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//         child: Row(
//           children: [
//             Container(
//               width: 70,
//               height: 70,
//               padding: EdgeInsets.all(10.sp),
//               decoration:
//                   BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//               child: Icon(
//                 icon,
//                 color: Color(0xFF080C27),
//                 size: 35,
//               ),
//             ),
//             SizedBox(width: 30.w),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontFamily: 'Inter',
//                     color: const Color(0xFF080C27),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 22.sp,
//                     fontFamily: 'Inter',
//                     color: const Color(0xFF080C27),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:easylibro_app/Dashboard/dashboard_service.dart';
import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
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

  static List<Resource>? cachedResources; // Static variable for caching

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
          _scrollController.jumpTo(0); // Reset scroll position to start
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
      cachedResources = resources; // Cache the fetched resources
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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color(0xFFF7F8FD),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: width * 0.06,
                  right: width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "👋Hello",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
                        color: Color(0xFF080C27),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Welcome to the easyLIBRO",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        color: Color(0xFF080C27),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LayoutScreen(currentIndex: 0)),
                    );
                  },
                  child: Search_Bar(
                    hintText: "Tap to Search more Resources",
                    controller: null,
                    enable: false,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, width: 1.sp
                  ),
                  color: const Color.fromARGB(255, 229, 229, 229),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Container(
                    decoration: BoxDecoration(),
                    height: 230.h,
                    width: double.infinity,
                    child: isLoading
                        ? Center(child: MyLoadingIndicator())
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
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
                        color: Color(0xFF080C27),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, width: 1.sp),
                        color: const Color(0xFFF7F8FD),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Column(
                          children: [
                            TileContainer(
                                "Status", status, Icons.warning_amber_rounded),
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
