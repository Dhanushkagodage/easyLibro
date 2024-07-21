import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoadingIndicator extends StatelessWidget {
  const MyLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: Center(
            child: LoadingAnimationWidget.discreteCircle(
          color: Color.fromARGB(187, 8, 12, 39),
          secondRingColor: Color.fromARGB(255, 1, 42, 71),
          thirdRingColor: Color.fromARGB(255, 131, 179, 252),
          size: 40.sp,
        )),
      ),
    );
  }
}
