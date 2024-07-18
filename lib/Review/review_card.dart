// import 'package:easylibro_app/Review/API/review.dart';
// import 'package:easylibro_app/Review/API/review_service.dart';
// import 'package:easylibro_app/widgets/alert_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ReviewCard extends StatefulWidget {
//   final Review review;
//   final VoidCallback fetchReviews;

//   const ReviewCard(
//       {super.key, required this.review, required this.fetchReviews});

//   @override
//   State<ReviewCard> createState() => _ReviewCardState();
// }

// class _ReviewCardState extends State<ReviewCard> {
//   String userName = '';
//   ReviewService reviewService = ReviewService();
  

//   @override
//   void initState() {
//     super.initState();
//     _getUserName();
//   }

//   Future<void> _getUserName() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     final storedUserName = localStorage.getString('userName');
//     setState(() {
//       userName = storedUserName!;
//     });
//   }

//   Future<void> _deleteReview() async {
//     try {
//       await reviewService.deleteReview(widget.review.id);
//     } catch (e) {
//       _showErrorSnackbar('Failed to delete review');
//     } finally {
//       widget.fetchReviews();
//       _showSuccessSnackbar('Review deleted successfully');
//     }
//   }

//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.error_outline,
//               color: Colors.white,
//             ),
//             SizedBox(width: 10.w),
//             Text(
//               message,
//               style: TextStyle(
//                 fontFamily: "Inter",
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void _showSuccessSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: Colors.white,
//             ),
//             SizedBox(width: 10.w),
//             Text(
//               message,
//               style: TextStyle(
//                 fontFamily: "Inter",
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Color.fromARGB(71, 74, 75, 76),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 10.h),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 40.w,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20.sp),
//                 child: Image.network(
//                   widget.review.imageUrl,
//                   height: 40.sp,
//                   width: 40.sp,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(width: 20.w),
//             Container(
//               width: 190.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.review.username,
//                     style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF0D4065)),
//                   ),
//                   SizedBox(height: 5.h),
//                   Text(
//                     widget.review.description,
//                     style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF6A6A6A)),
//                   ),
//                   SizedBox(height: 5.h),
//                   Row(
//                     children: List.generate(5, (index) {
//                       return Icon(
//                         Icons.star,
//                         color: index < widget.review.stars
//                             ? Colors.yellow
//                             : Color(0xFFBDBDBD),
//                         size: 20.sp,
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 10.w),
//             (widget.review.userId == userName)
//                 ? _buildDeleteButton()
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDeleteButton() {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertBox(
//                 title: 'Delete Review:',
//                 content: 'Are you sure you want to delete this review?',
//                 approveText: 'Yes',
//                 cancelText: 'No',
//                 onApprove: () {
//                   Navigator.of(context).pop();
//                   _deleteReview();
//                 },
//                 onCancel: () {
//                   Navigator.pop(context);
//                 },
//               );
//             });
//       },
//       child: Container(
//         padding: EdgeInsets.all(5.sp),
//         decoration: BoxDecoration(
//           color: Colors.red.shade50,
//           borderRadius: BorderRadius.circular(5.sp),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.delete_outline_outlined,
//               color: Colors.red,
//               size: 15.sp,
//             ),
//             Text(
//               'Delete',
//               style: TextStyle(
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w400,
//                 color: Colors.red,
//                 fontSize: 12.sp,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/Review/API/review_service.dart';
import 'package:easylibro_app/widgets/alert_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewCard extends StatefulWidget {
  final Review review;
  final VoidCallback fetchReviews;

  const ReviewCard(
      {super.key, required this.review, required this.fetchReviews});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String userName = '';
  bool isLoading = false;
  ReviewService reviewService = ReviewService();
  

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final storedUserName = localStorage.getString('userName');
    setState(() {
      userName = storedUserName!;
    });
  }

  Future<void> _deleteReview() async {
    setState(() {
      isLoading = true;
    });
    try {
      await reviewService.deleteReview(widget.review.id);
      widget.fetchReviews();
    } catch (e) {
      _showErrorSnackbar('Failed to delete review');
    } finally {   
      _showSuccessSnackbar('Review deleted successfully');
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          isLoading = false;
        });
      });
    }
    
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(71, 74, 75, 76),
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.sp),
                      child: Image.network(
                        widget.review.imageUrl,
                        height: 40.sp,
                        width: 40.sp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 190.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.review.username,
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0D4065)),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          widget.review.description,
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6A6A6A)),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color: index < widget.review.stars
                                  ? Colors.yellow
                                  : Color(0xFFBDBDBD),
                              size: 20.sp,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  (widget.review.userId == userName)
                      ? _buildDeleteButton()
                      : Container(),
                ],
              ),
            ),
          );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertBox(
                title: 'Delete Review:',
                content: 'Are you sure you want to delete this review?',
                approveText: 'Yes',
                cancelText: 'No',
                onApprove: () {
                  Navigator.of(context).pop();
                  _deleteReview();
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              );
            });
      },
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child: Row(
          children: [
            Icon(
              Icons.delete_outline_outlined,
              color: Colors.red,
              size: 15.sp,
            ),
            Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
