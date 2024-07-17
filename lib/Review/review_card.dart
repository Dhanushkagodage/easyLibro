// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ReviewCard extends StatefulWidget {
//   const ReviewCard({super.key});

//   @override
//   State<ReviewCard> createState() => _ReviewCardState();
// }

// class _ReviewCardState extends State<ReviewCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Color.fromARGB(71, 74, 75, 76),
//               width: 1,
//             ),
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 10.h),
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20.sp),
//                 child: Image.asset(
//                   "assets/Avatar.jpg",
//                   height: 40.sp,
//                   width: 40.sp,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(width: 20.w),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Username",
//                     style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF0D4065)),
//                   ),
//                   SizedBox(height: 5.h),
//                   Text(
//                     "This is a very good book. I recommend it t.",
//                     style: TextStyle(
//                         fontFamily: "Inter",
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF6A6A6A)),
//                   ),
//                   SizedBox(height: 5.h),
//                   Icon(
//                     Icons.star,
//                     color: Colors.yellow,
//                     size: 20.sp,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }


import 'package:easylibro_app/Review/API/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewCard extends StatefulWidget {
   final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.sp),
              child: Image.network(
                widget.review.imageUrl,
                height: 40.sp,
                width: 40.sp,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20.w),
            Column(
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
                      color: index < widget.review.stars ? Colors.yellow : Color(0xFFBDBDBD),
                      size: 20.sp,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
