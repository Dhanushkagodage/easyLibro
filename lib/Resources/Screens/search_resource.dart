// import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
// import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
// import 'package:easylibro_app/screens/error_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
// import 'package:easylibro_app/Resources/API/Models/resource.dart';
// import 'package:easylibro_app/Resources/Widgets/resource_card.dart';

// class SearchResource extends StatefulWidget {
//   const SearchResource({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SearchResourceState createState() => _SearchResourceState();
// }

// class _SearchResourceState extends State<SearchResource> {
//   int isSelected = 0;
//   String filterCategory = "Book";
//   bool isLoading = true;
//   bool hasError = false;
//   bool search = false;
//   String searchKeyword = "";
//   String searchTag = "all";
//   String searchType = "all";

//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchResources();
//   }

//   Future<void> _fetchResources() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       await MyResources.fetchResources(searchKeyword, searchTag, searchType)
//           .timeout(Duration(seconds: 8));
//     } catch (e) {
//       if (!mounted) return;
//       setState(() {
//         hasError = true;
//       });
//       // ignore: use_build_context_synchronously
//       showDialog(
//           context: context,
//           builder: (context) => AlertBox(
//                 content: "Failed to load resources",
//                 approveText: "OK",
//                 icon: Icons.error,
//                 iconColor: Colors.red,
//                 onApprove: () {},
//               ));
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF7F8FD),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Search_Bar(
//                     width: 230,
//                     hintText: "Search Resources",
//                     enable: true,
//                     controller: _searchController,
//                     onChanged: (value) {
//                       setState(() {
//                         searchKeyword = value;
//                       });
//                       _fetchResources();
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 40,
//                           width: 90,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 255, 255, 255),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(5),
//                                 bottomLeft: Radius.circular(5),
//                                 topRight: Radius.circular(0),
//                                 bottomRight: Radius.circular(0)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color.fromARGB(255, 49, 48, 52)
//                                     .withOpacity(0.9),
//                                 offset: Offset(0, 1),
//                                 blurRadius: 1,
//                               ),
//                             ],
//                             border: Border.all(
//                               color: Color(0xFF080C27).withOpacity(0.9),
//                               width: 0.7,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text("${filterCategory}s",
//                                 style: TextStyle(
//                                   color: Color(0xFF080C27),
//                                   fontSize: 14,
//                                   fontFamily: "Inter",
//                                   fontWeight: FontWeight.w500,
//                                 )),
//                           ),
//                         ),
//                         Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF0D4065),
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(0),
//                               bottomLeft: Radius.circular(0),
//                               topRight: Radius.circular(5),
//                               bottomRight: Radius.circular(5),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Color.fromARGB(255, 49, 48, 52)
//                                     .withOpacity(0.9),
//                                 offset: Offset(0, 1),
//                                 blurRadius: 2,
//                               ),
//                             ],
//                           ),
//                           child: PopupMenuButton<int>(
//                             onSelected: (value) {
//                               setState(() {
//                                 if (value == 1) {
//                                   filterCategory = "Book";
//                                 } else if (value == 2) {
//                                   filterCategory = "Journal";
//                                 } else {
//                                   filterCategory = "Ebook";
//                                 }
//                               });
//                             },
//                             color: Color.fromARGB(255, 255, 255, 255),
//                             offset: Offset(0, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             itemBuilder: (context) => [
//                               const PopupMenuItem(
//                                 value: 1,
//                                 child: Text("Books"),
//                               ),
//                               const PopupMenuItem(
//                                 value: 2,
//                                 child: Text("Journals"),
//                               ),
//                               const PopupMenuItem(
//                                 value: 3,
//                                 child: Text("Ebooks"),
//                               ),
//                             ],
//                             child: const Icon(
//                               Icons.tune_outlined,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildResourceCategory(index: 0, name: "All Resources"),
//                   _buildResourceCategory(index: 1, name: "Latest"),
//                   _buildResourceCategory(index: 2, name: "Popular"),
//                   // GestureDetector(
//                   //   onTap: () {

//                   //   },
//                   //   child: Container(
//                   //     width: 40,
//                   //     height: 40,
//                   //     decoration: BoxDecoration(
//                   //       borderRadius: BorderRadius.circular(5),
//                   //       color:const Color(0xFF0D4065)
//                   //     ),
//                   //     child: Icon(Icons.sort_by_alpha, color: Colors.white, size: 20),
//                   //   ),
//                   // )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : hasError
//                     ? Expanded(
//                         child: ErrorScreen(),
//                       )
//                     : Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: _buildResources(),
//                         ),
//                       ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildResourceCategory({required int index, required String name}) =>
//       GestureDetector(
//         onTap: () {
//           setState(() {
//             isSelected = index;
//           });
//         },
//         child: Container(
//           width: 110,
//           height: 40,
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: isSelected == index
//                 ? const Color(0xFF0D4065)
//                 : const Color(0xFFE1E2E2),
//           ),
//           child: Text(
//             name,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 13,
//               color:
//                   isSelected == index ? Colors.white : const Color(0xFF3F3D3D),
//               fontFamily: "Inter",
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       );

//   Widget _buildResources() {
//     List<Resource> resources;
//     if (isSelected == 0) {
//       resources = MyResources.getAllResourcesByCategory(filterCategory);
//     } else if (isSelected == 1) {
//       resources = MyResources.getLatestResources(filterCategory);
//     } else {
//       resources = MyResources.getPopularResources(filterCategory);
//     }

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: (100 / 200),
//       ),
//       itemCount: resources.length,
//       itemBuilder: (context, index) {
//         final resource = resources[index];
//         return ResourceCard(resource: resource);
//       },
//     );
//   }
// }

import 'package:easylibro_app/Resources/Widgets/alert_box.dart';
import 'package:easylibro_app/Resources/Widgets/search__bar.dart';
import 'package:easylibro_app/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:easylibro_app/Resources/API/Models/my_resource.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Resources/Widgets/resource_card.dart';

class SearchResource extends StatefulWidget {
  const SearchResource({super.key});

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

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchResources();
  }

  Future<void> _fetchResources() async {
    setState(() {
      isLoading = true;
    });
    try {
      await MyResources.fetchResources(searchKeyword, searchTag, searchType)
          .timeout(Duration(seconds: 8));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
      });
      print(e);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => AlertBox(
                content: "Failed to load resources",
                approveText: "OK",
                icon: Icons.error,
                iconColor: Colors.red,
                onApprove: () {},
              ));
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
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Search_Bar(
                    width: 230,
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
                                color: Color.fromARGB(255, 49, 48, 52)
                                    .withOpacity(0.9),
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
                            child: Text(filterCategory,
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
                  _buildResourceCategory(index: 0, name: "All Resources"),
                  _buildResourceCategory(index: 1, name: "Latest"),
                  _buildResourceCategory(index: 2, name: "Popular"),
                  // GestureDetector(
                  //   onTap: () {

                  //   },
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color:const Color(0xFF0D4065)
                  //     ),
                  //     child: Icon(Icons.sort_by_alpha, color: Colors.white, size: 20),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : hasError
                    ? Expanded(
                        child: ErrorScreen(),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildResources(),
                        ),
                      ),
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
          width: 110,
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
      resources = MyResources.getAllResourcesByCategory(filterCategory);
    } else if (isSelected == 1) {
      resources = MyResources.getLatestResources(filterCategory);
    } else {
      resources = MyResources.getPopularResources(filterCategory);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: (100 / 200),
      ),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return ResourceCard(resource: resource);
      },
    );
  }
}
