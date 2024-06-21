import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key}); // Using const constructor

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    List<String> imgSrc = [
      'assets/total..jpg',    // Update with your actual image paths
      'assets/novel.jpg',
      'assets/ebook.jpg',
      'assets/journals.jpg',
      'assets/users.jpg',
      'assets/total..jpg',
      'assets/total..jpg',
      'assets/total..jpg',
    ];

    List<String> titles = [
      "Total",
      "Navels",
      "E Books",
      "Journals",
      "Users",
      "Reservations",
      "Requests",
      "Overdue",
    ];

    return Scaffold(
      body: Container(
        color: Color(0xFF0D4065),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Last Update : ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white54,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02), // Adding space between sections
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                        left: 16.0,
                        right: 16.0,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Handle tap
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    imgSrc[index], // Displaying the image
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    titles[index], // Displaying the title
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20), // Adding some space at the bottom of the list
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
