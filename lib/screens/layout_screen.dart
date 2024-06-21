import 'package:easylibro_app/screens/dashboard_screen.dart';
import 'package:easylibro_app/screens/notification_screen.dart';
import 'package:easylibro_app/screens/search_resource.dart';
import 'package:easylibro_app/screens/userscreen.dart';
import 'package:easylibro_app/screens/userProfileEdit_screen.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const SearchResource(),
    const Userscreen(),
    const DashboardScreen(),
    const NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF7F8FD),
          toolbarHeight: 84,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 30,
              onPressed: () {},
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 18),
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/Avatar.jpeg"),
                  radius: 25,
                ),
              ),
            ),
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
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w100,
          ),
          selectedItemColor: const Color(0xFF080C27),
          unselectedLabelStyle: const TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w100,
          ),
          unselectedItemColor: Colors.white,
          iconSize: 28,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: "Resources",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Users",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "DashBoard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: "Notifications",
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LayoutScreen(),
  ));
}
