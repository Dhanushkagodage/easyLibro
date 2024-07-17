import 'package:easylibro_app/Requests/Api/request_services.dart';
import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/Review/API/review_service.dart';
import 'package:easylibro_app/Review/review_card.dart';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:easylibro_app/widgets/layout_screen.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:easylibro_app/Resources/Widgets/detailcontaier.dart';
import 'package:easylibro_app/Resources/API/Models/resource_details.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/Widgets/textdetail_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatefulWidget {
  final ResourceDetails resourceDetails;
  final UserDetails userDetails;
  final int requestCount;

  const AboutScreen(
      {super.key,
      required this.resourceDetails,
      required this.userDetails,
      required this.requestCount});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  RequestService requestService = RequestService();
  MyReviews myReviews = MyReviews();
  bool result = false;
  List<Review> allReviews = [];
  ReviewService reviewService = ReviewService();
  final TextEditingController _reviewcontroller = TextEditingController();
  final FocusNode _reviewFocusNode = FocusNode();

  @override
  void dispose() {
    _reviewcontroller.dispose();
    _reviewFocusNode.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    fetchReviews(widget.resourceDetails.isbn);
  }

  Future<void> fetchReviews(String isbn) async {
    try {
      List<Review> reviews = await reviewService.fetchReviews(isbn);
      setState(() {
        allReviews = reviews;
      });
    } catch (e) {
      print(e);
    }
  }


  void _showBorrowDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertBox(
          title: "Borrow:",
          content: "Are you sure you want to borrow this resource?",
          icon: Icons.error_outline,
          iconColor: Colors.yellow,
          approveText: "Yes",
          cancelText: "No",
          onApprove: () async {
            Navigator.of(context).pop();
            try {
              await requestService.addRequest(widget.resourceDetails.isbn);
              showDialog(
                context: parentContext,
                builder: (context) {
                  return AlertBox(
                    title: "Request:",
                    content: "Request has been sent successfully",
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    approveText: "Ok",
                    onApprove: () {
                      Navigator.push(
                        parentContext,
                        MaterialPageRoute(
                          builder: (context) => LayoutScreen(currentIndex: 3),
                        ),
                      );
                    },
                  );
                },
              );
            } catch (e) {
              print(widget.requestCount);
              if (widget.userDetails.status == "Loan") {
                showDialog(
                  context: parentContext,
                  builder: (context) {
                    return AlertBox(
                      title: "Error:",
                      content: "You are in a Loan",
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                      approveText: "Ok",
                      onApprove: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              } else if (widget.requestCount == 3) {
                showDialog(
                  context: parentContext,
                  builder: (context) {
                    return AlertBox(
                      title: "Error:",
                      content: "You have reached the maximum limit of requests",
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                      approveText: "Ok",
                      onApprove: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              } else {
                showDialog(
                  context: parentContext,
                  builder: (context) {
                    return AlertBox(
                      title: "Error:",
                      content: "An error occurred while sending request",
                      icon: Icons.error_outline,
                      iconColor: Colors.red,
                      approveText: "Ok",
                      onApprove: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              }
            }
          },
          onCancel: () {
            Navigator.of(context).reassemble();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final resourceDetails = widget.resourceDetails;
    //List<Review> allReviews = fetchReviews(resourceDetails.isbn);
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
                        height: 220.h,
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      iconTheme: IconThemeData(color: Color(0xFF080C27)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF080C27).withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 5,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width / 16 * 7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              resourceDetails.imagepath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: Text(
                        widget.resourceDetails.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF080C27),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
                    child: Container(
                      height: 27.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(72, 13, 64, 101),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Quantity Details: ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D4065)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailContainer(
                          label: "Total Qty.",
                          value: resourceDetails.total.toString(),
                          icon: Icons.credit_card_outlined,
                        ),
                        DetailContainer(
                          label: "Borrowed Qty.",
                          value: resourceDetails.borrowed.toString(),
                          icon: Icons.credit_card_off_outlined,
                        ),
                        DetailContainer(
                          label: "Available Qty.",
                          value: resourceDetails.remain.toString(),
                          icon: Icons.credit_score,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
                    child: Container(
                      height: 27.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(72, 13, 64, 101),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Location Details: ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D4065)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailContainer(
                          label: "Location",
                          value: resourceDetails.cupboardId,
                          icon: Icons.location_on,
                        ),
                        DetailContainer(
                          label: "Cupboard",
                          value: resourceDetails.cupboardName,
                          icon: Icons.location_on,
                        ),
                        DetailContainer(
                          label: "Shelf",
                          value: resourceDetails.shelfId,
                          icon: Icons.location_on,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Container(
                      height: 27,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(72, 13, 64, 101),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "${resourceDetails.title} Details: ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D4065)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 20.w, top: 10.h),
                    child: Container(
                      child: Column(
                        children: [
                          TextdetailContainer(
                            label: "Resource ID(ISBN)",
                            value: resourceDetails.isbn,
                          ),
                          TextdetailContainer(
                            label: "Author",
                            value: resourceDetails.author,
                          ),
                          TextdetailContainer(
                            label: "Resource Type",
                            value: resourceDetails.type,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextdetailContainer(
                            label: "No.of Pages",
                            value: resourceDetails.pages.toString(),
                          ),
                          TextdetailContainer(
                            label: "Price",
                            value: "Rs. ${resourceDetails.price}/-",
                          ),
                          TextdetailContainer(
                            label: "Date added",
                            value: resourceDetails.addedon.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Text.rich(TextSpan(
                        text: "Note: ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF080C27)),
                        children: [
                          TextSpan(text: "\n"),
                          TextSpan(
                            text: resourceDetails.description,
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6A6A6A)),
                          )
                        ])),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: GestureDetector(
                      onTap: () => _showBorrowDialog(context),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4065),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Request",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 27.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(72, 13, 64, 101),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Reviews (${allReviews.length})",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0D4065)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
                      child: _buildReviews(),
                    ),
                    Container(
                      height: 27.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(72, 13, 64, 101),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        "Add a Review: ",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0D4065)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.h, bottom: 20.h),
                      child: TextField(
                        controller: _reviewcontroller,
                        focusNode: _reviewFocusNode,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: BorderSide(
                              color: Color.fromARGB(72, 13, 64, 101),
                              width: 0.5.sp,
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF6A6A6A),
                          ),
                          hintText: 'Your Review',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: BorderSide(
                              color: Color.fromARGB(72, 13, 64, 101),
                              width: 0.5.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10.sp),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4065),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Submit Review",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
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

  Widget _buildReviews() {
    if (allReviews.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              color: Color(0xFF6A6A6A),
              size: 50.sp,
            ),
            Text(
              "No Reviews",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: Color(0xFF6A6A6A),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: allReviews.length,
        itemBuilder: (context, index) {
          final review = allReviews[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: ReviewCard(review: review),
          );
        },
      );
    }
  }
}
