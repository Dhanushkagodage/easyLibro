import 'package:easylibro_app/Reservations/API/reservation_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationdetailBox extends StatefulWidget {
  final Reservationdetails reservationDetails;
  const ReservationdetailBox({super.key, required this.reservationDetails});

  @override
  State<ReservationdetailBox> createState() => _ReservationdetailBoxState();
}

class _ReservationdetailBoxState extends State<ReservationdetailBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 195, 216, 246),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Container(
                width: 100.w,
                height: 150.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.reservationDetails.imagePath,
                      fit: BoxFit.cover,
                      width: 100.w,
                      height: 130.h,
                    ))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText('Reservation ID: ', widget.reservationDetails.resId.toString()),
                buildText('Resource ID: ', widget.reservationDetails.isbn),
                buildText('Book Title: ', widget.reservationDetails.bookTitle),
                buildText('Issue Date: ', widget.reservationDetails.dateIssue),
                buildText('Borrow Date: ', widget.reservationDetails.dateIssue),
                buildText('Due Date: ', widget.reservationDetails.dueDate),
                buildText('Return Date: ', widget.reservationDetails.returnDate),
                buildText('Penalty Status: ', widget.reservationDetails.penalty.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildText(String text, String value) {
  return Row(
    children: [
      Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 49, 49, 49),
        ),
      ),
      Text(
        value,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFF080C27),
        ),
      ),
    ],
  );
}
