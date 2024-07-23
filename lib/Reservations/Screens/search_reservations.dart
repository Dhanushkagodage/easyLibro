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

  Future<void> _handleRefresh() async {
    await _fetchReservations();
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
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Color(0xFF080C27),
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Search_Bar(
                      width: 372.w,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: _buildReservations(),
                          ),
                        ),
            ],
          ),
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
