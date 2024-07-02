// import 'dart:async';
// import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
// import 'package:easylibro_app/widgets/layout_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
// import 'package:easylibro_app/Resources/API/Models/resource.dart';
// import 'package:easylibro_app/Resources/Widgets/resource_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   List<Resource> resources = MyResources.getAllResourcesByCategory("All");
//   late ScrollController _scrollController;
//   late Timer _timer;
//   int _scrollCount = 0;
//   final double scrollAmount = 125;
//   late String userName;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     startAutoScroll();
//     getValidationData();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       if (_scrollCount < resources.length - 3) {
//         _scrollController.animateTo(
//           _scrollController.offset + scrollAmount,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//         _scrollCount++;
//       } else {
//         _timer.cancel(); // Stop the timer after scrolling 6 times
//       }
//     });
//   }

//   Future<void> getValidationData() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     final obtainedUserName = sharedPreferences.getString('userName');

//     setState(() {
//       userName = obtainedUserName!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final double height = MediaQuery.of(context).size.height;
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
//                       "👋Hello, $userName ",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Inter',
//                         color: Color(0xFF080C27),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "Welcome to the easyLIBRO",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: 'Inter',
//                         color: Color(0xFF080C27),
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 LayoutScreen(currentIndex: 0)),
//                       );
//                     },
//                     child: Search_Bar(
//                       hintText: "Tap to Search  more Resources",
//                       controller: null,
//                       enable: false,
//                       width: double.infinity,
//                     )),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Color(0xFF080C27).withOpacity(0.9),
//                     width: 0.7,
//                   ),
//                   color: const Color.fromARGB(255, 229, 229, 229),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Container(
//                     decoration: BoxDecoration(),
//                     height: 230,
//                     width: double
//                         .infinity, // Set a fixed height for the horizontal GridView
//                     child: resources.isEmpty
//                         ? Center(
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   "assets/error.png",
//                                   scale: 1.7,
//                                 ),
//                                 Text(
//                                   "No Resources Found",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: 'Inter',
//                                     color: Color(0xFF080C27),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : GridView.builder(
//                             controller: _scrollController,
//                             scrollDirection: Axis.horizontal,
//                             shrinkWrap: true,
//                             physics: BouncingScrollPhysics(),
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 1, // One row
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                               childAspectRatio: (200 / 100),
//                             ),
//                             itemCount: resources.length,
//                             itemBuilder: (context, index) {
//                               final resource = resources[index];
//                               return ResourceCard(resource: resource);
//                             },
//                           ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       border:
//                           Border.all(color: const Color(0xFF080C27), width: 1),
//                       color: const Color(0xFFF7F8FD),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         TileContainer(
//                             "Status", "FREE", Icons.warning_amber_rounded),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TileContainer(
//                             "My Reservations", "10", Icons.double_arrow),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TileContainer("My Requests", "20",
//                             Icons.perm_contact_calendar_rounded),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TileContainer(
//                             "Penalty", "0", Icons.trending_down_rounded),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget TileContainer(String title, String value, IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Color(0xFF080C27), width: 1),
//         color: Color(0xFFF7F8FD),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           children: [
//             Container(
//               width: 70,
//               height: 70,
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(35),
//                 color: Color.fromARGB(255, 131, 179, 252),
//               ),
//               child: Icon(
//                 icon,
//                 color: Color(0xFFF7F8FD),
//                 size: 35,
//               ),
//             ),
//             SizedBox(
//               width: 30,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Inter',
//                     color: const Color(0xFF080C27),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 22,
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

// import 'dart:async';
// import 'dart:convert';
// import 'package:easylibro_app/screens/error_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:easylibro_app/User/userdetails.dart';
// import 'package:easylibro_app/User/user_service.dart';
// import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
// import 'package:easylibro_app/widgets/layout_screen.dart';
// import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
// import 'package:easylibro_app/Resources/API/Models/resource.dart';
// import 'package:easylibro_app/Resources/Widgets/resource_card.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   List<Resource> resources = MyResources.getAllResourcesByCategory("All");
//   late ScrollController _scrollController;
//   late Timer _timer;
//   int _scrollCount = 0;
//   final double scrollAmount = 125;
//   UserDetails? userDetails;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       startAutoScroll();
//     });
//     fetchUserDetails();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void startAutoScroll() {
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       if (_scrollCount < resources.length - 3) {
//         _scrollController.animateTo(
//           _scrollController.offset + scrollAmount,
//           duration: Duration(seconds: 1),
//           curve: Curves.easeInOut,
//         );
//         _scrollCount++;
//       } else {
//         _timer.cancel(); // Stop the timer after scrolling 6 times
//       }
//     });
//   }

//   Future<void> fetchUserDetails() async {
//     setState(() {
//       isLoading = true;
//     });
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? userName = sharedPreferences.getString('userName');
//     if (userName == null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => ErrorScreen()),
//       );
//       return;
//     }

//     try {
//       UserDetails userDetails = await UserService.fetchUserDetails(userName);
//       setState(() {
//         this.userDetails = userDetails;
//       });
//     } catch (e) {
//       // Redirect to error screen if fetching user details fails
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => ErrorScreen()),
//       );
//     }finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: isLoading
//       ? Center(child: CircularProgressIndicator())
//       :userDetails == null
//           ? ErrorScreen()
//           : Container(
//               color: const Color(0xFFF7F8FD),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: 20,
//                         bottom: 20,
//                         left: width * 0.06,
//                         right: width * 0.06,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "👋Hello, ${"${userDetails!.fName} ${userDetails!.lName}"}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'Inter',
//                               color: Color(0xFF080C27),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             "Welcome to the easyLIBRO",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: 'Inter',
//                               color: Color(0xFF080C27),
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 20, right: 20, bottom: 20),
//                       child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       LayoutScreen(currentIndex: 0)),
//                             );
//                           },
//                           child: Search_Bar(
//                             hintText: "Tap to Search more Resources",
//                             controller: null,
//                             enable: false,
//                             width: double.infinity,
//                           )),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFF080C27).withOpacity(0.9),
//                           width: 0.7,
//                         ),
//                         color: const Color.fromARGB(255, 229, 229, 229),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Container(
//                           decoration: BoxDecoration(),
//                           height: 230,
//                           width: double
//                               .infinity, // Set a fixed height for the horizontal GridView
//                           child: resources.isEmpty
//                               ? Center(
//                                   child: Column(
//                                     children: [
//                                       Image.asset(
//                                         "assets/error.png",
//                                         scale: 1.7,
//                                       ),
//                                       Text(
//                                         "No Resources Found",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontFamily: 'Inter',
//                                           color: Color(0xFF080C27),
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : GridView.builder(
//                                   controller: _scrollController,
//                                   scrollDirection: Axis.horizontal,
//                                   shrinkWrap: true,
//                                   physics: BouncingScrollPhysics(),
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 1, // One row
//                                     crossAxisSpacing: 12,
//                                     mainAxisSpacing: 12,
//                                     childAspectRatio: (200 / 100),
//                                   ),
//                                   itemCount: resources.length,
//                                   itemBuilder: (context, index) {
//                                     final resource = resources[index];
//                                     return ResourceCard(resource: resource);
//                                   },
//                                 ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: const Color(0xFF080C27), width: 1),
//                             color: const Color(0xFFF7F8FD),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             children: [
//                               TileContainer("Status", userDetails!.status,
//                                   Icons.warning_amber_rounded),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               TileContainer(
//                                   "My Reservations", userDetails!.reservationcount.toString(), Icons.double_arrow),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               TileContainer("My Requests", "20",
//                                   Icons.perm_contact_calendar_rounded),
//                               SizedBox(height: 20),
//                               TileContainer(
//                                   "Penalty", "0", Icons.trending_down_rounded),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget TileContainer(String title, String value, IconData icon) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Color(0xFF080C27), width: 1),
//         color: Color(0xFFF7F8FD),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           children: [
//             Container(
//               width: 70,
//               height: 70,
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(35),
//                 color: Color.fromARGB(255, 131, 179, 252),
//               ),
//               child: Icon(
//                 icon,
//                 color: Color(0xFFF7F8FD),
//                 size: 35,
//               ),
//             ),
//             SizedBox(
//               width: 30,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Inter',
//                     color: const Color(0xFF080C27),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 22,
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
import 'package:easylibro_app/User/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/Widgets/resource_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ScrollController _scrollController;
  late Timer _timer;
  int _scrollCount = 0;
  final double scrollAmount = 125;
  bool isLoading = true;
  List<Resource> resources = [];
  MyResources myResources = MyResources();
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoScroll();
    });
    _fetchResources();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_scrollCount < resources.length - 3) {
        _scrollController.animateTo(
          _scrollController.offset + scrollAmount,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _scrollCount++;
      } else {
        _timer.cancel(); 
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
      isLoading = false;
    });
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
                      "👋Hello,hi}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
                        color: Color(0xFF080C27),
                        fontWeight: FontWeight.w500,
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LayoutScreen(currentIndex: 0)),
                      );
                    },
                    child: Search_Bar(
                      hintText: "Tap to Search more Resources",
                      controller: null,
                      enable: false,
                      width: double.infinity,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF080C27).withOpacity(0.9),
                    width: 0.7,
                  ),
                  color: const Color.fromARGB(255, 229, 229, 229),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(),
                    height: 230.h,
                    width: double
                        .infinity, // Set a fixed height for the horizontal GridView
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // One row
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: (200 / 100),
                            ),
                            itemCount: resources.length,
                            itemBuilder: (context, index) {
                              final resource = resources[index];
                              return ResourceCard(resource: resource);
                            },
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF080C27), width: 1),
                      color: const Color(0xFFF7F8FD),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TileContainer(
                            "Status", "FREE", Icons.warning_amber_rounded),
                        SizedBox(
                          height: 20,
                        ),
                        TileContainer(
                            "My Reservations", "10", Icons.double_arrow),
                        SizedBox(
                          height: 20,
                        ),
                        TileContainer("My Requests", "20",
                            Icons.perm_contact_calendar_rounded),
                        SizedBox(height: 20),
                        TileContainer(
                            "Penalty", "0", Icons.trending_down_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TileContainer(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF080C27), width: 1),
        color: Color(0xFFF7F8FD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Color.fromARGB(255, 131, 179, 252),
              ),
              child: Icon(
                icon,
                color: Color(0xFFF7F8FD),
                size: 35,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    color: const Color(0xFF080C27),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22,
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
