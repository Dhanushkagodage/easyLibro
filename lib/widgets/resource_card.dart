// // import 'package:easylibro_app/screens/about_screen.dart';
// // import 'package:easylibro_app/widgets/resource.dart';
// // import 'package:flutter/material.dart';

// // class ResourceCard extends StatefulWidget {
// //   final Resource resource;

// //   const ResourceCard({super.key, required this.resource});

// //   @override
// //   State<ResourceCard> createState() => _ResourceCardState();
// // }

// // class _ResourceCardState extends State<ResourceCard> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Color.fromARGB(255, 255, 255, 255),
// //         borderRadius: BorderRadius.circular(5),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Color.fromARGB(255, 49, 48, 52)
// //                 .withOpacity(0.1), // Shadow color
// //             spreadRadius: 2, // Spread radius
// //             blurRadius: 2, // Blur radius
// //             offset: const Offset(0, 0), // Changes position of shadow
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.asset(
// //               // widget.resource.imgURL,
// //               "assets/book image.png")),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   widget.resource.title,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(
// //                       fontFamily: "Inter",
// //                       fontSize: 13,
// //                       fontWeight: FontWeight.bold),
// //                 ),
// //                 Text(
// //                   'By ' '${widget.resource.author}',
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(fontSize: 8, fontFamily: "Inter"),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 8),
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) => AboutScreen(
// //                                     resource: Resource(
// //                                   isbn: widget.resource.isbn,
// //                                   title: widget.resource.title,
// //                                   author: widget.resource.author,
// //                                   noOfBooks: widget.resource.noOfBooks,
// //                                   url: widget.resource.url,
// //                                   // description:widget.resource.description,
// //                                   // totalqty:widget.resource.totalqty,
// //                                   // borrowedqty: widget.resource.borrowedqty,
// //                                   // location: widget.resource.location,
// //                                   type: widget.resource.type,
// //                                 ))),
// //                       );
// //                     },
// //                     child: Container(
// //                       height: 20,
// //                       width: double.infinity,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(2),
// //                         color: const Color(0xFF0D4065),
// //                       ),
// //                       child: Text(
// //                         "REQUEST",
// //                         style: TextStyle(
// //                             fontFamily: "Inter",
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.w400,
// //                             color: Colors.white),
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:easylibro_app/api_service.dart';
// import 'package:easylibro_app/screens/about_screen.dart';
// import 'package:easylibro_app/widgets/resource.dart';
// import 'package:flutter/material.dart';

// class ResourceCard extends StatefulWidget {
//   final Resource resource;

//   const ResourceCard({super.key, required this.resource});

//   @override
//   State<ResourceCard> createState() => _ResourceCardState();
// }

// class _ResourceCardState extends State<ResourceCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 255, 255, 255),
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromARGB(255, 49, 48, 52).withOpacity(0.1), // Shadow color
//             spreadRadius: 2, // Spread radius
//             blurRadius: 2, // Blur radius
//             offset: const Offset(0, 0), // Changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network(
//               widget.resource.url
//               )),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.resource.title,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       fontFamily: "Inter",
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'By ' '${widget.resource.author}',
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 8, fontFamily: "Inter"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: GestureDetector(
//                     onTap: () async {
//                       // Fetch resource details
//                       try {
//                         final resourceDetails = await ApiService.fetchResourceDetails(widget.resource.isbn);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AboutScreen(
//                               resource: widget.resource,
//                               resourceDetails: resourceDetails,
//                             ),
//                           ),
//                         );
//                       } catch (e) {
//                         // Handle any errors here
//                         print("Failed to fetch resource details: $e");
//                       }
//                     },
//                     child: Container(
//                       height: 20,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(2),
//                         color: const Color(0xFF0D4065),
//                       ),
//                       child: Text(
//                         "REQUEST",
//                         style: TextStyle(
//                             fontFamily: "Inter",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


import 'package:easylibro_app/api_service.dart';
import 'package:easylibro_app/screens/about_screen.dart';
import 'package:easylibro_app/widgets/resource.dart';
import 'package:flutter/material.dart';

class ResourceCard extends StatefulWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 49, 48, 52).withOpacity(0.1), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 2, // Blur radius
            offset: const Offset(0, 0), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: double.infinity, // Set to double.infinity to take full width
              height: 150, // Set a fixed height
              child: Image.network(
                widget.resource.url,
                fit: BoxFit.cover, // Ensures the image covers the box while maintaining aspect ratio
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resource.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'By ' '${widget.resource.author}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 8, fontFamily: "Inter"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () async {
                      // Fetch resource details
                      try {
                        final resourceDetails = await ApiService.fetchResourceDetails(widget.resource.isbn);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(
                              resource: widget.resource,
                              resourceDetails: resourceDetails,
                            ),
                          ),
                        );
                      } catch (e) {
                        // Handle any errors here
                        print("Failed to fetch resource details: $e");
                      }
                    },
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color(0xFF0D4065),
                      ),
                      child: Text(
                        "REQUEST",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
