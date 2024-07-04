import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailContainer extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;

  const DetailContainer({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: Color(0xFFB5D2FF), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding:  EdgeInsets.all(5.sp),
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: Color(0xFFF7F8FD),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Color.fromARGB(255, 131, 179, 252), width: 2.w)),
              child: Icon(widget.icon,color: Color(0xFF080C27),size: 20.sp ,),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 4.sp),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( widget.label,
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0D4065))),
                  Padding(
                    padding:  EdgeInsets.only(left: 15.w),
                    child: Text( widget.value,
                    overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF080C27))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
