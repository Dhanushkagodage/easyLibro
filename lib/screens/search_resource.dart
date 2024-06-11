// import 'package:easylibro_app/widgets/my_resource.dart';
// import 'package:easylibro_app/widgets/resource_card.dart';
// import 'package:easylibro_app/widgets/search__bar.dart';
// import 'package:flutter/material.dart';

// class SearchResource extends StatefulWidget {
//   const SearchResource({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SearchResourceState createState() => _SearchResourceState();
// }

// class _SearchResourceState extends State<SearchResource> {
//   int isSelected = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: const Color(0xFFF7F8FD),
//           //backgroundColor: Color.fromARGB(255, 17, 45, 188),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Search_Bar(hintText: "Search Resources"),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                                 color: const Color(0xFF0D4065),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: const Icon(
//                               Icons.tune_outlined,
//                               color: Colors.white,
//                               size: 25,
//                             ),
//                           ),
//                         )
//                       ]),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildResourceCategory(index: 0, name: "All Resources"),
//                         _buildResourceCategory(index: 1, name: "Latest"),
//                         _buildResourceCategory(index: 2, name: "Popular"),
//                         _buildResourceCategory(index: 3, name: "Recommended"),
//                         _buildResourceCategory(index: 4, name: "Popular"),
//                       ],
//                     ),

//                   ),
//                   const SizedBox(height:20),
//                   Column(
//                     children: [
//                       Expanded(child: isSelected ==0? _buildAllResources():_buillatestResources())
//                     ],
//                   ),

//                 ],
//               ),
//             ),
//           )),
//     );
//   }
//   _buildResourceCategory({required int index,required String name}) => Container(
//         width: 105,
//         height: 40,
//         margin: const EdgeInsets.only(top: 20, right: 30),
//         padding: const EdgeInsets.all(8),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: isSelected == index
//               ? const Color(0xFF0D4065) : const Color(0xFFE1E2E2),
//         ),
//         child: Text(name,style: TextStyle(
//           fontSize: 13,
//           color: isSelected== index ? Colors.white : const Color(0xFF3F3D3D),
//           fontFamily: "Inter",
//           fontWeight: FontWeight.w500,
//         ),),
//       );

//   _buildAllResources() => GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio:( 100 / 140),
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 10
//       ),
//       scrollDirection: Axis.vertical,
//       itemCount: MyResources.allResources.length,
//       itemBuilder: (context, index) {
//         final allResources = MyResources.allResources[index];
//         return ResourceCard(resource: allResources);
//       });

//   _buillatestResources() => GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio:( 100 / 140),
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 10
//       ),
//       scrollDirection: Axis.vertical,
//       itemCount: MyResources.latest.length,
//       itemBuilder: (context, index) {
//         final latest = MyResources.latest[index];
//         return ResourceCard(resource: latest);
//       });
// }


// import 'package:easylibro_app/widgets/my_resource.dart';
// import 'package:easylibro_app/widgets/resource.dart';
// import 'package:easylibro_app/widgets/resource_card.dart';
// import 'package:easylibro_app/widgets/search__bar.dart';
// import 'package:flutter/material.dart';

// class SearchResource extends StatefulWidget {
//   const SearchResource({super.key});

//   @override
//   _SearchResourceState createState() => _SearchResourceState();
// }

// class _SearchResourceState extends State<SearchResource> {
//   int isSelected = 0;
//   String filterCategory = "Books";

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF7F8FD),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 20, right: 20, top: 10, bottom: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Search_Bar(hintText: "Search Resources"),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Row(
//                       children: [
//                         Container(
//                             height: 40,
//                             width: 90,
//                             decoration: BoxDecoration(
//                               color: Color.fromARGB(255, 255, 255, 255),
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(5),
//                                   bottomLeft: Radius.circular(5),
//                                   topRight: Radius.circular(0),
//                                   bottomRight: Radius.circular(0)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color.fromARGB(255, 49, 48, 52)
//                                       .withOpacity(0.9),
//                                   offset: Offset(0, 1),
//                                   blurRadius: 1,
//                                 ),
//                               ],
//                               border: Border.all(
//                                 color: Color(0xFF080C27).withOpacity(0.9),
//                                 width: 0.7,
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(filterCategory,
//                                   style: TextStyle(
//                                     color: Color(0xFF080C27),
//                                     fontSize: 14,
//                                     fontFamily: "Inter",
//                                     fontWeight: FontWeight.w500,
//                                   )),
//                             )),
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
//                                   filterCategory = "Books";
//                                 } else if (value == 2) {
//                                   filterCategory = "Novels";
//                                 } else {
//                                   filterCategory = "Magazines";
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
//                                 child: Text("Novels"),
//                               ),
//                               const PopupMenuItem(
//                                 value: 3,
//                                 child: Text("Magazines"),
//                               ),
//                             ],
//                             child: const Icon(
//                               Icons.tune_outlined,
//                               color: Colors.white,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildResourceCategory(index: 0, name: "All Resources"),
//                     _buildResourceCategory(index: 1, name: "Latest"),
//                     _buildResourceCategory(index: 2, name: "Popular"),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: isSelected == 0
//                     ? _buildAllResources()
//                     : isSelected == 1
//                         ? _buildLatestResources()
//                         : _buildPopularResources(),
//               ),
//             ),
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
//           width: 105,
//           height: 40,
//           margin: const EdgeInsets.only(top: 10, right: 20),
//           padding: const EdgeInsets.all(8),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: isSelected == index
//                 ? const Color(0xFF0D4065)
//                 : const Color(0xFFE1E2E2),
//           ),
//           child: Text(
//             name,
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

//   Widget _buildAllResources() {
//     List<Resource> resources = MyResources.getAllResourcesByCategory(filterCategory);
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: ( 100 / 140),
//       ),
//       itemCount: resources.length,
//       itemBuilder: (context, index) {
//         final resource = resources[index];
//         return ResourceCard(resource: resource);
//       },
//     );
//   }

//   Widget _buildLatestResources() {
//     List<Resource> resources = MyResources.getLatestResources(filterCategory);
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: ( 100 / 140),
//       ),
//       itemCount: resources.length,
//       itemBuilder: (context, index) {
//         final resource = resources[index];
//         return ResourceCard(resource: resource);
//       },
//     );
//   }

//   Widget _buildPopularResources() {
//     List<Resource> resources = MyResources.getPopularResources(filterCategory);
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//         childAspectRatio: ( 100 / 140),
//       ),
//       itemCount: resources.length,
//       itemBuilder: (context, index) {
//         final resource = resources[index];
//         return ResourceCard(resource: resource);
//       },
//     );
//   }
// }
import 'package:easylibro_app/widgets/my_resource.dart';
import 'package:easylibro_app/widgets/resource.dart';
import 'package:easylibro_app/widgets/resource_card.dart';
import 'package:easylibro_app/widgets/search__bar.dart';
import 'package:flutter/material.dart';

class SearchResource extends StatefulWidget {
  const SearchResource({super.key});

  @override
  _SearchResourceState createState() => _SearchResourceState();
}

class _SearchResourceState extends State<SearchResource> {
  int isSelected = 0;
  String filterCategory = "Book"; // Default category

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Search_Bar(hintText: "Search Resources"),
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
                                  filterCategory = "Novel";
                                } else {
                                  filterCategory = "Magazine";
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
                                child: Text("Novels"),
                              ),
                              const PopupMenuItem(
                                value: 3,
                                child: Text("Magazines"),
                              ),
                            ],
                            child: const Icon(
                              Icons.tune_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildResourceCategory(index: 0, name: "All Resources"),
                    _buildResourceCategory(index: 1, name: "Latest"),
                    _buildResourceCategory(index: 2, name: "Popular"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
          width: 105,
          height: 40,
          margin: const EdgeInsets.only(top: 10, right: 20),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelected == index
                ? const Color(0xFF0D4065)
                : const Color(0xFFE1E2E2),
          ),
          child: Text(
            name,
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
    
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true, // Added to make the GridView take only the necessary height
        physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
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
      ),
    );
  }
}
