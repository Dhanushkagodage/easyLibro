import 'package:easylibro_app/Reservations/API/Reservation.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatefulWidget {
  final Reservation reservation;

  const ReservationCard({super.key, required this.reservation});

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 85,
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F8FD),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.wifi_protected_setup,
                    color: Color(0xFF080C27),
                    size: 25,
                  )),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Reservations: ${widget.reservation.reservationNo}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Resource: ${widget.reservation.Resource}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Due Date: ${widget.reservation.DueDate}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Row(children: [
                  Text(
                    'Status :',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 70,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xFF0D4065),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          widget.reservation.Status,
                          style: TextStyle(
                            color: Color(0xFFF7F8FD),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                   width: 70,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xFF080C27),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'More',
                          style: TextStyle(
                            color: Color(0xFFF7F8FD),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                ),

              ],
            ),
          ],
        ));
  }
}
