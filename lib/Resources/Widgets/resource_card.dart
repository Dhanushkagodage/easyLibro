import 'package:easylibro_app/Requests/Api/my_requests.dart';
import 'package:easylibro_app/Resources/API/resource_service.dart';
import 'package:easylibro_app/Resources/Screens/about_screen.dart';
import 'package:easylibro_app/Resources/API/Models/resource.dart';
import 'package:easylibro_app/Review/API/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResourceCard extends StatefulWidget {
  final Future<double> Function() fetchRating;
  final Resource resource;

  const ResourceCard(
      {super.key, required this.resource, required this.fetchRating});

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard> {
  final ResourceService _resourceService = ResourceService();

  final MyRequests myRequest = MyRequests();
  List<Review> allReviews = [];
  MyReviews myReviews = MyReviews();
  double rating = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() {
      isLoading = true;
    });
    try {
      double fetchedRating = await widget.fetchRating();
      setState(() {
        rating = fetchedRating;
        isLoading = false;
      });
    } catch (e) {
      //print("Failed to fetch reviews: $e");
    }
  }

  Color _containerColor = const Color(0xFF0D4065);
  void _changeColorTemporarily() {
    setState(() {
      _containerColor = Color.fromARGB(154, 13, 64, 101);
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _containerColor = const Color(0xFF0D4065);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.fetchRating();
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
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: double.infinity,
                height: 150.h,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Image.network(
                    widget.resource.url,
                    fit: BoxFit.cover,
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
            Positioned(
              top: 5.h,
              right: 5.w,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(177, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    children: [
                      isLoading
                          ? SizedBox(
                              height: 15.sp,
                              width: 15.sp,
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(168, 255, 255, 255),
                                strokeWidth: 2.sp,
                              ))
                          : Text('$rating/5',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(8.sp),
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
                  padding: EdgeInsets.only(top: 5.h),
                  child: GestureDetector(
                    onTap: () async {
                      _changeColorTemporarily();
                      try {
                        final resourceDetails = await _resourceService
                            .fetchResourceDetails(widget.resource.isbn);

                        if (!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(
                              resourceDetails: resourceDetails,
                            ),
                          ),
                        );

                        print(widget.resource.isbn);
                      } catch (e) {
                        print("Failed to fetch resource details: $e");
                      }
                    },
                    child: Container(
                      height: 22.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: _containerColor,
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
