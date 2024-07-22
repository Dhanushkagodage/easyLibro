import 'package:easylibro_app/Requests/Api/my_requests.dart';
import 'package:easylibro_app/Resources/Widgets/textdetail_container.dart';
import 'package:easylibro_app/User/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easylibro_app/Requests/Api/request_services.dart';
import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/Review/API/review_service.dart';
import 'package:easylibro_app/Review/review_card.dart';
import 'package:easylibro_app/User/userdetails.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:easylibro_app/Resources/Widgets/detailcontaier.dart';
import 'package:easylibro_app/Resources/API/Models/resource_details.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:easylibro_app/widgets/wave_clipper.dart';

class AboutScreen extends StatefulWidget {
  final ResourceDetails resourceDetails;

  const AboutScreen({
    super.key,
    required this.resourceDetails,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final UserService _userService = UserService();
  final MyRequests myRequest = MyRequests();
  RequestService requestService = RequestService();
  ReviewService reviewService = ReviewService();
  TextEditingController reviewcontroller = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();
  int _rating = 0;
  UserDetails? userDetails;
  int requestCount = 0;
  bool isloading = false;
  List<Review> allReviews = [];
  List<String> isbnList = [];

  Color _requestButtonColor = const Color(0xFF0D4065);
  Color _submitButtonColor = const Color(0xFF0D4065);

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _onRequestTap() {
    setState(() {
      _requestButtonColor = Color.fromARGB(160, 13, 64, 101);
    });
    _showBorrowDialog(context);

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _requestButtonColor = const Color(0xFF0D4065);
      });
    });
  }

  void _onSubmitReviewTap() {
    setState(() {
      _submitButtonColor = Color.fromARGB(160, 13, 64, 101);
    });
    submitReview(reviewcontroller.text, widget.resourceDetails.isbn, _rating);
    fetchReviews(widget.resourceDetails.isbn);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _submitButtonColor = const Color(0xFF0D4065);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReviews(widget.resourceDetails.isbn);
  }

  Future<void> fetchReviews(String isbn) async {
    try {
      List<Review> reviews = await reviewService.fetchReviews(isbn);
      final requests = await myRequest.fetchRequests();
      final userDetails = await _userService.fetchUserDetails();
      List<String> isbnList = myRequest.getIsbnList();
      setState(() {
        allReviews = reviews;
        requestCount = requests.length;
        this.isbnList = isbnList;
        this.userDetails = userDetails;
      });
    } catch (e) {
      print(e);
    }
  }

  void _showBorrowDialog(BuildContext context) {
    showDialog(
      context: context,
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
              setState(() {
                isloading = true;
              });
              await requestService.addRequest(widget.resourceDetails.isbn);
              setState(() {
                isloading = false;
              });
              _showSuccessSnackbar('Request has been sent successfully');
            } catch (e) {
              setState(() {
                isloading = false;
              });
              _handleRequestError(context, e);
            }
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void _handleRequestError(BuildContext context, dynamic error) {
    String message;
    if (userDetails != null && userDetails!.status == "Loan") {
      message = "You are in a Loan";
    } else if (requestCount == 3) {
      message = "You have reached the maximum limit of requests";
    } else if (isbnList.contains(widget.resourceDetails.isbn)) {
      message = "You have already requested this resource";
    } else {
      message = "An error occurred while sending the request";
    }
    _showErrorSnackbar(message);
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              message,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void submitReview(String reviewText, String isbn, int rating) async {
    if (reviewText.isEmpty) {
      _showErrorSnackbar('Review cannot be empty');
      return;
    }
    final review = AddReview(
      description: reviewText,
      isbn: isbn,
      stars: rating,
    );
    try {
      setState(() {
        isloading = true;
      });
      await reviewService.addReview(review);
      fetchReviews(isbn);
      reviewcontroller.clear();
      _setRating(0);
      setState(() {
        isloading = false;
      });
      _showSuccessSnackbar('Review submitted successfully');
    } catch (e) {
      setState(() {
        isloading = false;
      });
      _showErrorSnackbar('Failed to submit review');
    }
  }

  Future<void> _handleRefresh() async {
    await fetchReviews(widget.resourceDetails.isbn);
  }

  @override
  Widget build(BuildContext context) {
    final resourceDetails = widget.resourceDetails;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Stack(
          children: [
            Scaffold(
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
                                width:
                                    MediaQuery.of(context).size.width / 16 * 7,
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
                          padding: EdgeInsets.only(
                              left: 20.w, top: 10.h, right: 20.w),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
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
                          padding: EdgeInsets.only(
                              left: 20.w, top: 10.h, right: 20.w),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
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
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20),
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
                          padding: EdgeInsets.only(
                              left: 40.w, right: 20.w, top: 10.h),
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
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0D4065)),
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
                            onTap: () {
                              _onRequestTap();
                            },
                            //=> _showBorrowDialog(context),
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _requestButtonColor,
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
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 30.h),
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
                                top: 10.h,
                                bottom: 10.h,
                                left: 20.w,
                                right: 20.w),
                            child: _buildReviews(),
                          ),
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
                            padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                            child: TextField(
                              controller: reviewcontroller,
                              keyboardType: TextInputType.text,
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
                          Row(
                            children: List.generate(5, (index) {
                              return SizedBox(
                                width: 30.sp,
                                child: IconButton(
                                  icon: Icon(
                                    index < _rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: index < _rating
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    _setRating(index + 1);
                                  },
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              _onSubmitReviewTap();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _submitButtonColor,
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
            if (isloading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: MyLoadingIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    if (allReviews.isEmpty) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.tray,
                size: 50.sp,
                color: Color.fromARGB(255, 175, 175, 175),
              ),
              Text(
                'No Requests',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  color: Color.fromARGB(255, 175, 175, 175),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
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
            child: ReviewCard(
                review: review,
                fetchReviews: () => fetchReviews(widget.resourceDetails.isbn)),
          );
        },
      );
    }
  }
}
