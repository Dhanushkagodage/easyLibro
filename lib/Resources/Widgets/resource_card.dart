
import 'package:easylibro_app/Resources/API/resource_service.dart';
import 'package:easylibro_app/Resources/Screens/about_screen.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResourceCard extends StatefulWidget {
  final Resource resource;

  const ResourceCard({super.key, required this.resource});

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {

  final ResourceService _resourceService = ResourceService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
          width: 1,
        ), 
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width:
                  double.infinity,
              height: 150.h, 
              child: Padding(
                padding: const EdgeInsets.only(top:1),
                child: Image.network(
                  widget.resource.url,
                  fit: BoxFit
                      .cover, // Ensures the image covers the box while maintaining aspect ratio
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Icon(Icons.error, color: Colors.red);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.resource.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'By ' '${widget.resource.author}', 
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 8.sp, fontFamily: "Inter"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 5.h),
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        final resourceDetails =
                            await _resourceService.fetchResourceDetails(
                                widget.resource.isbn);
                        if (!mounted) return;
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AboutScreen(resourceDetails: resourceDetails),
                          ),
                        );
                        // ignore: avoid_print
                        print(widget.resource.isbn);
                      } catch (e) {
                        // Handle any errors here
                        // ignore: avoid_print
                        print("Failed to fetch resource details: $e");
                      }
                    },
                    child: Container(
                      height: 22.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: const Color(0xFF0D4065),
                      ),
                      child: Center(
                        child: Text(
                          "REQUEST",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
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
