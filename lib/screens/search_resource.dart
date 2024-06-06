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

import 'package:easylibro_app/widgets/my_resource.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Search_Bar(hintText: "Search Resources"),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D4065),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.tune_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildResourceCategory(index: 0, name: "All Resources"),
                      _buildResourceCategory(index: 1, name: "Latest"),
                      _buildResourceCategory(index: 2, name: "Popular"),
                      _buildResourceCategory(index: 3, name: "Recommended"),
                      _buildResourceCategory(index: 4, name: "Popular"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Flexible(
                //   fit: FlexFit.loose,
                //   child: isSelected == 0
                //       ? _buildAllResources()
                //       : _buildLatestResources(),
                // ),
                Expanded(child: _buildAllResources())
              ],
            ),
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
          width: 105,
          height: 40,
          margin: const EdgeInsets.only(top: 20, right: 30),
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

  Widget _buildAllResources() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 10,
            childAspectRatio: 4 / 5),
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: MyResources.allResources.length,
        itemBuilder: (context, index) {
          final allResources = MyResources.allResources[index];
          return ResourceCard(resource: allResources);
        },
      );

  Widget _buildLatestResources() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 100,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: MyResources.latest.length,
        itemBuilder: (context, index) {
          final latest = MyResources.latest[index];
          return ResourceCard(resource: latest);
        },
      );
}
