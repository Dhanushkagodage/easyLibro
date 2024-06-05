// import 'package:easylibro_app/widgets/search__bar.dart';
// import 'package:flutter/material.dart';

// class SearchResource extends StatelessWidget {
//   const SearchResource({super.key});

//   // ignore: non_constant_identifier_names

//   @override
//   Widget build(BuildContext context) {
//     //  TextEditingController Searchbarcontroller = TextEditingController();

//     return SafeArea(
//       child: Scaffold(
//           body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Search_Bar(hintText: "Search books", controller: Searchbarcontroller),
//                   Search_Bar(hintText: "Search Resources"),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20),
//                     child: Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF0D4065),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: const Icon(
//                         Icons.tune_outlined,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                   )
//                 ]),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Container(
//                 height: 60,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(width: 20),
//                       _allitem(""),
//                       SizedBox(width: 20),
//                       _singleitem("Popular"),
//                       SizedBox(width: 20),
//                       _singleitem("Latest"),
//                       SizedBox(width: 20),
//                       _singleitem("Latest"),
                    
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// Widget _allitem(String searchtext) {
//   return ElevatedButton(
//     style: const ButtonStyle(
//       backgroundColor: WidgetStatePropertyAll(Color(0xFF0D4065)),
//     ),
//     child: const Text("All",style: const TextStyle(
//           fontSize: 14,
//           color: Color.fromARGB(255, 255, 255, 255),
//           fontFamily: "Inter",
//           fontWeight: FontWeight.w500),),
//     onPressed: () {},
//   );
// }

// Widget _singleitem(String searchtext) {
//   return ElevatedButton(
//     child: Text(
//       searchtext,
//       style: const TextStyle(
//           fontSize: 14,
//           color: Color(0xFF080C27),
//           fontFamily: "Inter",
//           fontWeight: FontWeight.w500),
//     ),
//     onPressed: () {},
//   );
// }


import 'package:easylibro_app/widgets/search__bar.dart';
import 'package:flutter/material.dart';

class SearchResource extends StatefulWidget {
  const SearchResource({super.key});

  @override
  _SearchResourceState createState() => _SearchResourceState();
}

class _SearchResourceState extends State<SearchResource> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Search_Bar(hintText: "Search Resources"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xFF0D4065),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.tune_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20),
                      _categoryItem("All"),
                      const SizedBox(width: 20),
                      _categoryItem("Popular"),
                      const SizedBox(width: 20),
                      _categoryItem("Latest"),
                      const SizedBox(width: 20),
                      _categoryItem("Trending"),
                      const SizedBox(width: 20),
                      _categoryItem("Recommended"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _categoryItem(String category) {
    bool isSelected = selectedCategory == category;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isSelected ? const Color(0xFF0D4065) : Colors.grey,
        ),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? Colors.white : const Color(0xFF080C27),
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
    );
  }
}
