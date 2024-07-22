import 'package:easylibro_app/Review/API/review.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:easylibro_app/widgets/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/Widgets/resource_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResource extends StatefulWidget {
  final VoidCallback fetchunreadcount;
  const SearchResource({super.key, required this.fetchunreadcount});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResourceState createState() => _SearchResourceState();
}

class _SearchResourceState extends State<SearchResource> {
  int isSelected = 0;
  String filterCategory = "All";
  bool isLoading = true;
  bool hasError = false;
  bool search = false;
  String searchKeyword = "";
  String searchTag = "all";
  String searchType = "all";
  final myResource = MyResources();
  final myReviews = MyReviews();

  final TextEditingController _searchController = TextEditingController();

  Future<void> _handleRefresh() async {
    await _fetchResources();
  }

  @override
  void initState() {
    super.initState();
    _fetchResources();
    widget.fetchunreadcount();
  }

  Future<void> _fetchResources() async {
    setState(() {
      isLoading = true;
    });
    try {
      await myResource.fetchResources(searchKeyword, searchTag, searchType);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
      });
      _showErrorSnackbar("Failed to Load Resources");
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

  Future<double> fetchRating(String isbn) async {
    return await myReviews.fetchRating(isbn);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Search_Bar(
                      width: 230.w,
                      hintText: "Search Resources",
                      enable: true,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchKeyword = value;
                        });
                        _fetchResources();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Row(
                        children: [
                          Container(
                            height: 45.h,
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
                                  color: Color.fromARGB(255, 210, 210, 210),
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                ),
                              ],
                              border: Border.all(
                                color: Color.fromARGB(255, 210, 210, 210),
                                width: 1.w,
                              ),
                            ),
                            child: Center(
                              child: Text(filterCategory,
                                  style: TextStyle(
                                    color: Color(0xFF080C27),
                                    fontSize: 14.sp,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                          Container(
                            height: 45.h,
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
                                  color: Color.fromARGB(255, 210, 210, 210),
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
                                    filterCategory = "Ebook";
                                  } else {
                                    filterCategory = "Journal";
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
                                  child: Text("Ebooks"),
                                ),
                                const PopupMenuItem(
                                  value: 3,
                                  child: Text("Journals"),
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
                    _buildResourceCategory(index: 0, name: "All Resources"),
                    _buildResourceCategory(index: 1, name: "Latest"),
                    _buildResourceCategory(index: 2, name: "Popular"),
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
                            child: _buildResources(),
                          ),
                        ),
            ],
          ),
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
          width: 110.w,
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

  Widget _buildResources() {
    List<Resource> resources;
    if (isSelected == 0) {
      resources = myResource.getAllResourcesByCategory(filterCategory);
    } else if (isSelected == 1) {
      resources = myResource.getLatestResources(filterCategory);
    } else {
      resources = myResource.getPopularResources(filterCategory);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: (100.w / 200.h),
      ),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return ResourceCard(
            resource: resource, fetchRating: () => fetchRating(resource.isbn));
      },
    );
  }
}
