// import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
// import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
// import 'package:easylibro_app/Resources/Screens/search_resource.dart';
// import 'package:easylibro_app/Notifications/notification_screen.dart';
// import 'package:easylibro_app/User/userProfileEdit_screen.dart';
// import 'package:flutter/material.dart';

// class LayoutScreen extends StatefulWidget {
//   final int currentIndex;

//   const LayoutScreen({super.key, required this.currentIndex});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   late int currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex;
//   }

//   List<Widget> screens =  [
//     SearchResource(),
//     SearchReservations(),
//     DashboardScreen(),
//     NotificationScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(85),
//           child: Container(
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color:  Color.fromARGB(109, 8, 12, 39),
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
//                 padding: const EdgeInsets.only(top: 12,bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.asset(
//                       "assets/librarylogoRW1.png",
//                       scale: 5.6,
//                     ),
//                     const Text(
//                       "Read your Favourite Books!",
//                       style: TextStyle(
//                         fontSize: 12,
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
//                       backgroundImage: AssetImage("assets/Avatar.jpeg"),
//                       radius: 25,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: screens[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: const Color(0xFF0D4065),
//           selectedLabelStyle: const TextStyle(
//               fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
//           selectedItemColor: const Color(0xFF080C27),
//           unselectedLabelStyle: const TextStyle(
//               fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
//           unselectedItemColor: Colors.white,
//           iconSize: 28,
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.menu_book_outlined), label: "Resources"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.wifi_protected_setup), label: "Reservations"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard_outlined), label: "DashBoard"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.notifications_outlined), label: "Notifications"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
// import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
// import 'package:easylibro_app/Resources/Screens/search_resource.dart';
// import 'package:easylibro_app/Notifications/notification_screen.dart';
// import 'package:easylibro_app/User/userProfileEdit_screen.dart';
// import 'package:easylibro_app/User/user_service.dart';
// import 'package:easylibro_app/User/userdetails.dart';
// import 'package:easylibro_app/screens/error_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LayoutScreen extends StatefulWidget {
//   final int currentIndex;

//   const LayoutScreen({super.key, required this.currentIndex});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   late int currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex;
//     fetchUserDetails();
//   }

//   List<Widget> screens =  [
//     SearchResource(),
//     SearchReservations(),
//     DashboardScreen(),
//     NotificationScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(85),
//           child: Container(
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color:  Color.fromARGB(109, 8, 12, 39),
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
//                 padding: const EdgeInsets.only(top: 12,bottom: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [

//                     Image.network(userDetails.image, scale: 5.6,),
//                     const Text(
//                       "Read your Favourite Books!",
//                       style: TextStyle(
//                         fontSize: 12,
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
//                       backgroundImage: AssetImage("assets/Avatar.jpeg"),
//                       radius: 25,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: screens[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: const Color(0xFF0D4065),
//           selectedLabelStyle: const TextStyle(
//               fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
//           selectedItemColor: const Color(0xFF080C27),
//           unselectedLabelStyle: const TextStyle(
//               fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
//           unselectedItemColor: Colors.white,
//           iconSize: 28,
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.menu_book_outlined), label: "Resources"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.wifi_protected_setup), label: "Reservations"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard_outlined), label: "DashBoard"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.notifications_outlined), label: "Notifications"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
// import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
// import 'package:easylibro_app/Resources/Screens/search_resource.dart';
// import 'package:easylibro_app/Notifications/notification_screen.dart';
// import 'package:easylibro_app/User/userProfileEdit_screen.dart';
// import 'package:easylibro_app/User/user_service.dart';
// import 'package:easylibro_app/User/userdetails.dart';
// import 'package:easylibro_app/screens/error_screen.dart';

// class LayoutScreen extends StatefulWidget {
//   final int currentIndex;

//   const LayoutScreen({super.key, required this.currentIndex});

//   @override
//   State<LayoutScreen> createState() => _LayoutScreenState();
// }

// class _LayoutScreenState extends State<LayoutScreen> {
//   late int currentIndex;
//   UserDetails? userDetails;
//   List<Widget> screens = [];

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex;
//     fetchUserDetails();
//   }

//   Future<void> fetchUserDetails() async {
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
//         screens = [
//           SearchResource(),
//           SearchReservations(),
//           DashboardScreen(userDetails: userDetails),
//           NotificationScreen(),
//         ];
//       });
//     } catch (e) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => ErrorScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize:  Size.fromHeight(85.h),
//           child: Container(
//             decoration:  BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Color.fromARGB(109, 8, 12, 39),
//                   width: 1.w,
//                 ),
//               ),
//             ),
//             child: AppBar(
//               surfaceTintColor: const Color(0xFFF7F8FD),
//               backgroundColor: const Color(0xFFF7F8FD),
//               toolbarHeight: 85.h,
//               automaticallyImplyLeading: false,
//               leading: Padding(
//                 padding: EdgeInsets.only(left: 20.w),
//                 child: IconButton(
//                   icon: const Icon(Icons.menu),
//                   color: const Color(0xFF080C27),
//                   iconSize: 30.sp,
//                   onPressed: () {},
//                 ),
//               ),
// title: Padding(
//   padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Image.asset(
//         "assets/librarylogoRW1.png",
//         scale: 5.7.sp,
//       ),
//        Text(
//         "Read your Favourite Books!",
//         style: TextStyle(
//           fontSize: 12.sp,
//           color: Color(0xFF080C27),
//           fontFamily: "Inter",
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ],
//   ),
// ),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20.w),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (userDetails != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 EditProfilePage(userDetails: userDetails!),
//                           ),
//                         );
//                       }
//                     },
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage("assets/Avatar.jpeg"),
//                       radius: 28.sp,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         body: screens.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : screens[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: const Color(0xFF0D4065),

//           selectedLabelStyle:  TextStyle(
//               fontFamily: "Inter", fontSize: 12.sp, fontWeight: FontWeight.normal),
//           selectedItemColor: const Color(0xFF080C27),
//           unselectedLabelStyle:  TextStyle(
//               fontFamily: "Inter", fontSize: 12.sp, fontWeight: FontWeight.normal),
//           unselectedItemColor: Colors.white,
//           iconSize: 28.sp,
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.menu_book_outlined), label: "Resources"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.wifi_protected_setup), label: "Reservations"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard_outlined), label: "DashBoard"),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.notifications_outlined),
//                 label: "Notifications"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
import 'package:easylibro_app/Dashboard/dashboard_screen.dart';
import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/Notifications/notification_screen.dart';
import 'package:easylibro_app/User/userProfileEdit_screen.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:easylibro_app/User/userdetails.dart';
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

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    UserService userService = UserService();
    try {
      UserDetails details = await userService.fetchUserDetails();
      setState(() {
        userDetails = details;
      });
    } catch (e) {
      //print("Error fetching user details: $e");
    }
  }

  List<Widget> screens = [
    SearchResource(),
    SearchReservations(),
    DashboardScreen(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(109, 8, 12, 39),
                  // Color of the border
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
                    Image.asset(
                      "assets/librarylogoRW1.png",
                      scale: 5.7.sp,
                    ),
                    Text(
                      "Read your Favourite Books!",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFF080C27),
                        fontFamily: "Inter",
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
                    child: CircleAvatar(
                      backgroundImage: userDetails != null
                          ? NetworkImage(userDetails!.image)
                          : AssetImage("assets/Capture.JPG") as ImageProvider,
                      radius: 28.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0D4065),
          selectedLabelStyle:  TextStyle(
              fontFamily: "Inter", fontSize: 12.sp, fontWeight: FontWeight.normal),
          selectedItemColor: const Color(0xFF080C27),
          unselectedLabelStyle:  TextStyle(
              fontFamily: "Inter", fontSize: 12.sp, fontWeight: FontWeight.normal),
          unselectedItemColor: Colors.white,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined), label: "Resources"),
            BottomNavigationBarItem(
                icon: Icon(Icons.wifi_protected_setup), label: "Reservations"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined), label: "DashBoard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: "Notifications"),
          ],
        ),
      ),
    );
  }
}


