import 'package:easylibro_app/Reservations/API/reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationCard extends StatefulWidget {
  final Reservation reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity,
          height: 85.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 49, 48, 52).withOpacity(0.1),
                offset: const Offset(0, 0),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.only(right: 10.w),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8FD),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(
                          Icons.wifi_protected_setup,
                          color: Color(0xFF080C27),
                          size: 25.sp,
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                          'Reservations: ${widget.reservation.reservationNo}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Resource: ${widget.reservation.resource}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Due Date: ${widget.reservation.dueDate}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    
                    children: [
                      SizedBox(height: 5.h),
                      Row(children: [
                        Text(
                          'Status :',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Container(
                            width: 70.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF0D4065),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                widget.reservation.status,
                                style: TextStyle(
                                  color: Color(0xFFF7F8FD),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                         width: 70.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF080C27),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'More',
                                style: TextStyle(
                                  color: Color(0xFFF7F8FD),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                      ),
              
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
