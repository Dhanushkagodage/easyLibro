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
import 'package:easylibro_app/widgets/popup_filter.dart';
import 'package:easylibro_app/widgets/resource_card.dart';
import 'package:easylibro_app/widgets/search__bar.dart';
import 'package:flutter/material.dart';

class SearchResource extends StatefulWidget {

  const SearchResource({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResourceState createState() => _SearchResourceState();
}

class _SearchResourceState extends State<SearchResource> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FD),
        body: Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
              child: Row(
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
                      child: GestureDetector(
                        onTap: () {
                           Navigator.push(
                               context,
                              MaterialPageRoute(
                                  builder: (context) => PopupFilter()));
                        
                        },
                        child: const Icon(
                          Icons.tune_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
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
            Padding(
              padding: const EdgeInsets.only(left:20,right: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height-300,
                child: isSelected == 0
                    ? _buildAllResources()
                    : isSelected == 1
                        ? _buildLatestResources()
                        : _buildPopularResources(),
              ),
            )
            
            
            // Expanded(child: isSelected == 0
            //         ? _buildAllResources()
            //         : isSelected == 1
            //             ? _buildLatestResources()
            //             : _buildPopularResources(),)
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

  Widget _buildAllResources() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
             childAspectRatio: (1 / 2)
           ),
        shrinkWrap: true,
        //physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: MyResources.allResources.length,
        itemBuilder: (context, index) {
          final allResources = MyResources.allResources[index];
          return ResourceCard(resource: allResources);
        },
      );

  Widget _buildLatestResources() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (1 / 2),
          crossAxisSpacing: 12,
          mainAxisSpacing: 100,
        ),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: MyResources.latest.length,
        itemBuilder: (context, index) {
          final latest = MyResources.latest[index];
          return ResourceCard(resource: latest);
        },
      );
  Widget _buildPopularResources() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
           childAspectRatio: (1 / 2),
          crossAxisSpacing: 12,
          mainAxisSpacing: 100,
        ),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: MyResources.popular.length,
        itemBuilder: (context, index) {
          final popular = MyResources.popular[index];
          return ResourceCard(resource: popular);
        },
      );
}
