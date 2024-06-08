import 'package:easylibro_app/screens/layout_screen.dart';
import 'package:easylibro_app/widgets/detailcontaier.dart';
import 'package:easylibro_app/widgets/resource.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/widgets/textdetail_container.dart';

class AboutScreen extends StatefulWidget {
  final Resource resource;

  const AboutScreen({super.key, required this.resource});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF7F8FD),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Color.fromARGB(71, 12, 127, 250),
                      height: 220,
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Color(0xFF080C27)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF080C27)
                                  .withOpacity(0.5), // Shadow color
                              spreadRadius: 4, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset:
                                  Offset(0, 0), // Changes position of shadow
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width / 16 * 7,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              widget.resource.imgURL,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Center(
                    child: Text(
                  widget.resource.title,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF080C27)),
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailContainer(
                        label: "Total Qty.",
                        value: widget.resource.totalqty.toString(),
                        icon: Icons.credit_card_outlined),
                    DetailContainer(
                        label: "Borrowed Qty.",
                        value: widget.resource.borrowedqty.toString(),
                        icon: Icons.credit_card_off_outlined),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailContainer(
                        label: "Available Qty.",
                        value: (widget.resource.totalqty -
                                widget.resource.borrowedqty)
                            .toString(),
                        icon: Icons.credit_score),
                    DetailContainer(
                        label: "Location",
                        value: widget.resource.location,
                        icon: Icons.location_on),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20),
                  child: Container(
                    child: Column(
                      children: [
                        TextdetailContainer(
                            label: "Resource ID(ISBN)",
                            value: widget.resource.isbn),
                        TextdetailContainer(
                            label: "Auther", value: widget.resource.auther),
                        TextdetailContainer(
                            label: "Resource Type", value: "Book"),
                        SizedBox(
                          height: 20,
                        ),
                        TextdetailContainer(
                            label: "Publish Year", value: "2000"),
                        TextdetailContainer(label: "No.of Pages", value: "400"),
                        TextdetailContainer(
                            label: "Price", value: "Rs. 2000/-"),
                        TextdetailContainer(
                            label: "AddedON", value: "2021-09-20"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text.rich(TextSpan(
                      text: "Note: ",
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF080C27)),
                      children: [
                        TextSpan(
                          text: "\n", // Add a newline character
                        ),
                        TextSpan(
                            text: "      ${widget.resource.description}",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6A6A6A)))
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LayoutScreen(currentIndex: 2)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 12 * 5,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFF6A6A6A),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Return",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  LayoutScreen(currentIndex: 0)),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 12 * 5,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFF0D4065),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Borrow",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
