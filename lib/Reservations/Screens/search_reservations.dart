import 'package:easylibro_app/Reservations/widgets/reservation_card.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Reservations/API/my_reservations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchReservations extends StatefulWidget {
  const SearchReservations({super.key});

  @override
  State<SearchReservations> createState() => _SearchReservationsState();
}

class _SearchReservationsState extends State<SearchReservations> {
  int isSelected = 0;
  String filterCategory = "Book";
  bool isLoading = true;
  String searchKeyword = "";
  String searchTag = "all";
  String searchType = "all";

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Search_Bar(
                    hintText: "Search Reservations ",
                    controller: _searchController,
                    enable: true,
                    width: 230.w,
                    onChanged: (value) {
                      // setState(() {
                      //   searchKeyword = value;
                      // });
                      // _fetchResources();
                    },
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 10.w),
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
                            child: Text("${filterCategory}s",
                                style: TextStyle(
                                  color: Color(0xFF080C27),
                                  fontSize: 14.sp,
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
                                  filterCategory = "Book";
                                } else if (value == 2) {
                                  filterCategory = "Journal";
                                } else {
                                  filterCategory = "Ebook";
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
                                child: Text("Books"),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text("Journals"),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Text("Ebooks"),
                              ),
                            ],
                            child:  Icon(
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
              padding:  EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildResourceCategory(index: 0, name: "All"),
                  _buildResourceCategory(index: 1, name: "Due"),
                  _buildResourceCategory(index: 2, name: "Borrowed"),
                  _buildResourceCategory(index: 3, name: "Reserved"),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            // isLoading
            //     ? Center(child: CircularProgressIndicator())
            //     : Expanded(
            //         child:
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.sp),
                child: _buildReservations(),
              ),
            ),
            //       ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceCategory({required int index, required String name}) =>
      GestureDetector(
        onTap: () {
          setState(() {
            isSelected = index;
          });
        },
        child: Container(
          width: 85.w,
          height: 40.h,
          padding:  EdgeInsets.all(8.sp),
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
              fontSize: 13.sp,
              color:
                  isSelected == index ? Colors.white : const Color(0xFF3F3D3D),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

  Widget _buildReservations() {
    return ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 20),
        itemCount: MyReservations.allReservations.length,
        itemBuilder: (context, index) {
          final reservation = MyReservations.allReservations[index];
          return Padding(
            padding:  EdgeInsets.only(bottom: 10.h),
            child: ReservationCard(
              reservation: reservation,
            ),
          );
        });
  }
}
