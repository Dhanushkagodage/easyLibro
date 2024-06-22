import 'dart:async';
import 'package:easylibro_app/Resources/Screens/search_resource.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/Widgets/resource_card.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Resource> resources = MyResources.getLatestResources("Book");
  late ScrollController _scrollController;
  late Timer _timer;
  int _scrollCount = 0;
  final double scrollAmount = 125; // Amount to scroll horizontally

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    startAutoScroll();
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
        _timer.cancel(); // Stop the timer after scrolling 6 times
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
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
                      "👋Hello, Sasindu...",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        color: const Color(0xFF080C27),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Welcome to the easyLIBRO",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: const Color(0xFF080C27),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20,bottom:5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(

              //         height: 25,
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: const Color(0xFF080C27), width: 1),
              //           color: Color.fromARGB(255, 255, 255, 255),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.only(left:5,right: 5),
              //           child: Text(
              //             "Latest Books",
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontFamily: 'Inter',
              //               color: const Color(0xFF080C27),
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(

              //         height: 25,
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //               color: const Color(0xFF080C27), width: 1),
              //           color: Color.fromARGB(255, 255, 255, 255),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.only(left:5,right: 5),
              //           child: Text(
              //             "Tap to view more..",
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontFamily: 'Inter',
              //               color: const Color(0xFF080C27),
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                      hintText: "Tap to Search  more Resources",
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
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(),
                    height:
                        230, // Set a fixed height for the horizontal GridView
                    child: GridView.builder(
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
                        SizedBox(
                          height: 20,
                        ),
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
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25),
      //   color: Color.fromARGB(255, 131, 179, 252),
      // ),
      // child: Icon(icon, color: Color.fromARGB(255, 5, 5, 5)),
    );
  }
}
