// import 'package:easylibro_app/Notifications/notification_service.dart';
// import 'package:easylibro_app/Requests/Screens/request_screen.dart';
// import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
// import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
// import 'package:easylibro_app/Resources/Screens/search_resource.dart';
// import 'package:easylibro_app/Notifications/notification_screen.dart';
// import 'package:easylibro_app/User/edit_profilepage.dart';
// import 'package:easylibro_app/User/user_service.dart';
// import 'package:easylibro_app/User/userdetails.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LayoutScreen extends StatefulWidget {
//   final int currentIndex;

//   const LayoutScreen({super.key, required this.currentIndex});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   late int currentIndex;
//   UserDetails? userDetails;
//   UserService userService = UserService();
//   NotificationService notificationService = NotificationService();
//   int notificationCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex;
//     fetchUserDetails();
//     fetchunreadcount();
//   }

//   Future<void> fetchUserDetails() async {
//     try {
//       UserDetails details = await userService.fetchUserDetails();
//       setState(() {
//         userDetails = details;
//       });
//     } catch (e) {
//       print("Error fetching user details: $e");
//     }
//   }

//   Future<int> fetchunreadcount() async {
//     try {
//       int count = await notificationService.getUnreadNotificationsCount();
//       setState(() {
//         notificationCount = count;
//       });
//       //print("Notification count: $count");
//       return count;
//     } catch (e) {
//       print("Error fetching notification count: $e");
//       return 0;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       SearchResource(fetchunreadcount: fetchunreadcount),
//       SearchReservations(fetchunreadcount: fetchunreadcount),
//       DashboardScreen(fetchunreadcount: fetchunreadcount),
//       RequestScreen(fetchunreadcount: fetchunreadcount),
//       NotificationScreen(fetchunreadcount: fetchunreadcount),
//     ];
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(85),
//           child: Container(
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color.fromARGB(109, 8, 12, 39),
//                   // Color of the border
//                   width: 1.0, // Width of the border
//                 ),
//               ),
//             ),
//             child: AppBar(
//               surfaceTintColor: const Color(0xFFF7F8FD),
//               backgroundColor: const Color(0xFFF7F8FD),
//               toolbarHeight: 85,
//               automaticallyImplyLeading: false,
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: IconButton(
//                   icon: const Icon(Icons.menu),
//                   color: const Color(0xFF080C27),
//                   iconSize: 30,
//                   onPressed: () {},
//                 ),
//               ),
//               title: Padding(
//                 padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       "assets/librarylogoRW1.png",
//                       scale: 7.sp,
//                     ),
//                     Text(
//                       "Read your Favourite Books!",
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Color(0xFF080C27),
//                         fontFamily: "Inter",
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditProfilePage(),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       backgroundImage: userDetails != null
//                           ? NetworkImage(userDetails!.image)
//                           : AssetImage("assets/Capture.JPG") as ImageProvider,
//                       radius: 28.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: screens[currentIndex],
//         bottomNavigationBar: Container(
//           decoration: const BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 color: Color.fromARGB(109, 8, 12, 39),
//                 width: 1.0,
//               ),
//             ),
//           ),
//           child: BottomNavigationBar(
//             currentIndex: currentIndex,
//             onTap: (index) {
//               setState(() {
//                 currentIndex = index;
//                 fetchUserDetails();
//               });
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: const Color(0xFFF7F8FD),
//             selectedLabelStyle: TextStyle(
//                 fontFamily: "Inter",
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600),
//             selectedItemColor: const Color(0xFF0D4065),
//             unselectedLabelStyle: TextStyle(
//                 fontFamily: "Inter",
//                 fontSize: 10.sp,
//                 fontWeight: FontWeight.w500),
//             unselectedItemColor: const Color(0xFF0D4065),
//             selectedIconTheme: IconThemeData(size: 28),
//             unselectedIconTheme: IconThemeData(size: 26),
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.book),
//                   label: "Resources",
//                   activeIcon: Icon(CupertinoIcons.book_solid)),
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.arrow_up_arrow_down_square),
//                   label: "Reservations",
//                   activeIcon:
//                       Icon(CupertinoIcons.arrow_up_arrow_down_square_fill)),
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.square_grid_2x2),
//                   label: "DashBoard",
//                   activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill)),
//               BottomNavigationBarItem(
//                   icon: Icon(CupertinoIcons.arrow_up_right_square),
//                   label: "Requests",
//                   activeIcon: Icon(CupertinoIcons.arrow_up_right_square_fill)),
//               BottomNavigationBarItem(
//                   icon: Stack(
//                     children: [
//                       Icon(CupertinoIcons.bell),
//                       if (notificationCount > 0)
//                         Positioned(
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(6.sp),
//                             ),
//                             constraints: BoxConstraints(
//                               minWidth: 16.sp,
//                               minHeight: 16.sp,
//                             ),
//                             child: Text(
//                               '$notificationCount+',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10.sp,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   label: "Notifications",
//                   activeIcon: Icon(CupertinoIcons.bell_fill)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:easylibro_app/Notifications/notification_service.dart';
import 'package:easylibro_app/Requests/Screens/request_screen.dart';
import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/Notifications/notification_screen.dart';
import 'package:easylibro_app/User/edit_profilepage.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutScreen extends StatefulWidget {
  final int currentIndex;

  const LayoutScreen({super.key, required this.currentIndex});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late int currentIndex;
  UserDetails? userDetails;
  UserService userService = UserService();
  NotificationService notificationService = NotificationService();
  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    fetchUserDetails();
    fetchunreadcount();
  }

  Future<void> fetchUserDetails() async {
    try {
      UserDetails details = await userService.fetchUserDetails();
      setState(() {
        userDetails = details;
      });
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<int> fetchunreadcount() async {
    try {
      int count = await notificationService.getUnreadNotificationsCount();
      setState(() {
        notificationCount = count;
      });
      //print("Notification count: $count");
      return count;
    } catch (e) {
      print("Error fetching notification count: $e");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      SearchResource(fetchunreadcount: fetchunreadcount),
      SearchReservations(fetchunreadcount: fetchunreadcount),
      DashboardScreen(fetchunreadcount: fetchunreadcount),
      RequestScreen(fetchunreadcount: fetchunreadcount),
      NotificationScreen(fetchunreadcount: fetchunreadcount),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF080C27), // Color of the border
                  width: 1.0, // Width of the border
                ),
              ),
            ),
            child: AppBar(
              surfaceTintColor: const Color(0xFFF7F8FD),
              backgroundColor: const Color(0xFFF7F8FD),
              toolbarHeight: 85,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  color: const Color(0xFF080C27),
                  iconSize: 30,
                  onPressed: () {},
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   "assets/librarylogoRW1.png",
                    //   scale: 7.sp,
                    // ),
                    Container(
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.book_fill,
                            color: Color(0xFF080C27),
                            size: 28.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "easyLibro",
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: Color(0xFF080C27),
                              fontFamily: "AlternateGotNo3D",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Read your Favourite Books!",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF080C27),
                        fontFamily: "AlternateGotNo3D",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ),
                      );
                    },
                    child: Stack(
  alignment: Alignment.center,
  children: [
    Container(
      height: 56.sp,
      width: 56.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xFF080C27),
          width: 2.sp,
        ),
      ),
    ),
    Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundImage: userDetails != null
            ? NetworkImage(userDetails!.image)
            : AssetImage("assets/Capture.JPG") as ImageProvider,
        radius: 25.sp,
      ),
    ),
  ],
)

                  ),
                ),
              ],
            ),
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFF080C27),
                width: 1.0,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                fetchUserDetails();
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFF7F8FD),
            selectedLabelStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
            selectedItemColor: Color(0xFF080C27),
            unselectedLabelStyle: TextStyle(
                fontFamily: "Inter",
                fontSize: 10.sp,
                fontWeight: FontWeight.w500),
            unselectedItemColor: Color(0xFF080C27),
            selectedIconTheme: IconThemeData(size: 28),
            unselectedIconTheme: IconThemeData(size: 26),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book),
                  label: "Resources",
                  activeIcon: Icon(CupertinoIcons.book_solid)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.arrow_up_arrow_down_square),
                  label: "Reservations",
                  activeIcon:
                      Icon(CupertinoIcons.arrow_up_arrow_down_square_fill)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_grid_2x2),
                  label: "DashBoard",
                  activeIcon: Icon(CupertinoIcons.square_grid_2x2_fill)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.arrow_up_right_square),
                  label: "Requests",
                  activeIcon: Icon(CupertinoIcons.arrow_up_right_square_fill)),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(CupertinoIcons.bell),
                      if (notificationCount > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6.sp),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16.sp,
                              minHeight: 16.sp,
                            ),
                            child: Text(
                              '$notificationCount+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: "Notifications",
                  activeIcon: Icon(CupertinoIcons.bell_fill)),
            ],
          ),
        ),
      ),
    );
  }
}
