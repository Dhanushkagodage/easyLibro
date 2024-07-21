import 'package:easylibro_app/Reservations/API/reservation.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Reservations/widgets/reservation_card.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';

import 'package:easylibro_app/Reservations/API/my_reservations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchReservations extends StatefulWidget {
  final VoidCallback fetchunreadcount;
  const SearchReservations({super.key, required this.fetchunreadcount});

  @override
  State<SearchReservations> createState() => _SearchReservationsState();
}

class _SearchReservationsState extends State<SearchReservations> {
  int isSelected = 0;
  String filterCategory = "All";
  bool isLoading = true;
  bool hasError = false;
  bool search = false;
  String searchKeyword = "";
  String searchType = "all";
  final myReservation = MyReservations();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchReservations();
    widget.fetchunreadcount();
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

  Future<void> _fetchReservations() async {
    setState(() {
      isLoading = true;
    });
    try {
      await myReservation.fetchReservations(searchKeyword, searchType);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
      });
      _showErrorSnackbar("Failed to Load Reservations");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Search_Bar(
                    width: 230.w,
                    hintText: "Search Reservations",
                    enable: true,
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        searchKeyword = value;
                      });
                      _fetchReservations();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 49, 48, 52)
                                    .withOpacity(0.9),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF080C27).withOpacity(0.9),
                              width: 0.7.w,
                            ),
                          ),
                          child: Center(
                            child: Text(filterCategory,
                                style: TextStyle(
                                  color: Color(0xFF080C27),
                                  fontSize: 12.sp,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D4065),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 49, 48, 52)
                                    .withOpacity(0.9),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: PopupMenuButton<int>(
                            onSelected: (value) {
                              setState(() {
                                if (value == 1) {
                                  filterCategory = "All";
                                } else if (value == 2) {
                                  filterCategory = "Reservation";
                                } else if (value == 3) {
                                  filterCategory = "User";
                                } else {
                                  filterCategory = "Resource";
                                }
                              });
                            },
                            color: Color.fromARGB(255, 255, 255, 255),
                            offset: Offset(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 1,
                                child: Text("All"),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text("Reservation"),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Text("User"),
                              ),
                              const PopupMenuItem(
                                value: 4,
                                child: Text("Resource"),
                              ),
                            ],
                            child: Icon(
                              Icons.tune_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildReservationCategory(index: 0, name: "All"),
                  _buildReservationCategory(index: 1, name: "Due"),
                  _buildReservationCategory(index: 2, name: "Borrowed"),
                  _buildReservationCategory(index: 3, name: "Received"),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            isLoading
                ? Expanded(child: MyLoadingIndicator())
                : hasError
                    ? Expanded(
                        child: ErrorScreen(),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildReservations(),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCategory(
          {required int index, required String name}) =>
      GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
          width: 80.w,
          height: 40.h,
          padding: EdgeInsets.all(8.sp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected == index
                ? const Color(0xFF0D4065)
                : const Color(0xFFE1E2E2),
          ),
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              color:
                  isSelected == index ? Colors.white : const Color(0xFF3F3D3D),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Widget _buildReservations() {
    List<Reservation> reservations = [];
    if (isSelected == 0) {
      reservations = myReservation.getAll(filterCategory);
    } else if (isSelected == 1) {
      reservations = myReservation.getDue(filterCategory);
    } else if (isSelected == 2) {
      reservations = myReservation.getBorrowed(filterCategory);
    } else {
      reservations = myReservation.getReceived(filterCategory);
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 20.h),
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservation = reservations[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: ReservationCard(
              reservation: reservation,
            ),
          );
        });
  }
}
