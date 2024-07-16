import 'package:easylibro_app/Reservations/API/reservation.dart';
import 'package:easylibro_app/Reservations/API/reservation_details.dart';
import 'package:easylibro_app/Reservations/API/reservation_service.dart';
import 'package:easylibro_app/Reservations/widgets/reservation_detail_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationCard extends StatefulWidget {
  final Reservation reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  bool _isExpanded = false;
  final ReservationService _reservationService = ReservationService();
  Reservationdetails? _reservationDetails;

  @override
  void initState() {
    super.initState();
    _fetchReservationDetails();
  }

  Future<void> _fetchReservationDetails() async {
    try {
      final reservationDetails = await _reservationService.fetchReservationDetails(widget.reservation.reservationNo);
      setState(() {
        _reservationDetails = reservationDetails;
      });
    } catch (e) {
      // Handle the error properly here
      print('Failed to load reservation details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 49, 48, 52).withOpacity(0.1),
              offset: const Offset(0, 0),
              blurRadius: 3,
            ),
          ],
          border: Border.all(
            color: Colors.grey, width: 1.sp
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                      width: 40.sp,
                      height: 40.sp,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Icon(
                        Icons.wifi_protected_setup,
                        color: Color(0xFF080C27),
                        size: 25.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
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
                        SizedBox(height: 10.h),
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
                      
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                          child: Container(
                            width: 70.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: _isExpanded ? Color.fromARGB(157, 8, 12, 39) : Color(0xFF080C27),
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_isExpanded && _reservationDetails != null)
              ReservationdetailBox(reservationDetails: _reservationDetails!),  // Pass the state variable
          ],
        ),
      ),
    );
  }
}
