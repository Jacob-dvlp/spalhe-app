import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:spalhe/components/layout/modal/modal.dart';

class ImageListController extends GetxController {
  int index = 0;

  void setIndex(int index) {
    this.index = index;
    update();
  }
}

void showImageModal(List<String> urls, int index, {bool? isBinary = false}) {
  Navigator.of(Get.context!).push(ModalComponent(
    children: [
      GetBuilder<ImageListController>(
        init: ImageListController(),
        builder: (cntler) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: PageView(
                  onPageChanged: (value) => cntler.setIndex(value),
                  scrollDirection: Axis.horizontal,
                  scrollBehavior: ScrollBehavior(),
                  children: urls.map((el) {
                    if (isBinary == true) {
                      return PhotoView(
                        imageProvider: MemoryImage(base64Decode(el)),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.contained,
                        basePosition: Alignment.center,
                      );
                    }
                    return PhotoView(
                      imageProvider: NetworkImage(el),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained,
                      basePosition: Alignment.center,
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (urls.length > 1)
                          Container(
                            child: Text(
                              '${cntler.index + 1}/${urls.length}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        else
                          Container(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(Get.context!).pop(),
                            icon: Icon(
                              FeatherIcons.x,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  ));
}
