
import 'package:easylibro_app/screens/dashboard_screen.dart';
import 'package:easylibro_app/screens/notification_screen.dart';

import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/screens/userscreen.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  final int currentIndex;

  const LayoutScreen({super.key, required this.currentIndex});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  List<Widget> screens =  [
    SearchResource(),
    Userscreen(),
    DashboardScreen(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: const Color(0xFFF7F8FD),
          backgroundColor: const Color(0xFFF7F8FD),
          toolbarHeight: 80,
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
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/librarylogoRW1.png",
                  scale: 5.6,
                ),
                const Text(
                  "Read your Favourite Books!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF080C27),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/Avatar.jpeg"),
                radius: 25,
              ),
            )
          ],
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
          selectedLabelStyle: const TextStyle(
              fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
          selectedItemColor: const Color(0xFF080C27),
          unselectedLabelStyle: const TextStyle(
              fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal),
          unselectedItemColor: Colors.white,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined), label: "Resources"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: "Users"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined), label: "DashBoard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined), label: "Notifications"),
          ],
        ),
      ),
    );
  }
}
