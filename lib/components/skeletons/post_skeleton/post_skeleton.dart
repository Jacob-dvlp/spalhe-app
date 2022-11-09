import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

class PostSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Skeleton(
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        child: Container(),
        isLoading: true,
        skeleton: SkeletonItem(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 45,
                        width: 45,
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 8,
                            width: 200,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        SizedBox(height: 6),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 6,
                            width: 100,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
