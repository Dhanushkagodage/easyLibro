import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Search_Bar(
                    hintText: "Search Reservations ",
                    controller: _searchController,
                    onChanged: (value) {
                      // setState(() {
                      //   searchKeyword = value;
                      // });
                      // _fetchResources();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 49, 48, 52).withOpacity(0.9),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF080C27).withOpacity(0.9),
                              width: 0.7,
                            ),
                          ),
                          child: Center(
                            child: Text("${filterCategory}s",
                                style: TextStyle(
                                  color: Color(0xFF080C27),
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
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
                                color: Color.fromARGB(255, 49, 48, 52).withOpacity(0.9),
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
                            child: const Icon(
                              Icons.tune_outlined,
                              color: Colors.white,
                              size: 20,
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //           child: _buildResources(),
            //         ),
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
          width: 85,
          height: 40,
          padding: const EdgeInsets.all(8),
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
              fontSize: 13,
              color: isSelected == index ? Colors.white : const Color(0xFF3F3D3D),
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

}