
import 'package:easylibro_app/Reservations/Screens/search_reservations.dart';
import 'package:easylibro_app/screens/dashboard_screen.dart';
import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/screens/notification_screen.dart';
import 'package:easylibro_app/screens/userProfileEdit_screen.dart';
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
                  color:  Color.fromARGB(109, 8, 12, 39), 
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
                padding: const EdgeInsets.only(top: 12,bottom: 10),
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
                      backgroundImage: AssetImage("assets/Avatar.jpeg"),
                      radius: 25,
                    ),
                  ),
                )
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
                icon: Icon(Icons.wifi_protected_setup), label: "Reservations"),
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
