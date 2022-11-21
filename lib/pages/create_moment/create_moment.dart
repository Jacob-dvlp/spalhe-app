import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/pages/create_moment/components/stickers/components/hours/hours.dart';
import 'package:spalhe/pages/create_moment/components/stickers/components/music/music_card.dart';
import 'package:spalhe/pages/create_moment/components/stickers/stickers.dart';
import 'package:spalhe/pages/create_moment/components/item_moment/item_moment.dart';
import 'package:spalhe/pages/create_moment/controller/create_moment.controller.dart';
import 'package:spalhe/pages/create_moment/models/item_moment.model.dart';

final img =
    'https://img.freepik.com/fotos-gratis/paisagem-vertical-com-lago-de-montanhas_1398-3850.jpg?w=2000';

class CreateMomentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMomentController>(
      init: CreateMomentController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white, size: 30),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: Icon(FeatherIcons.download),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FeatherIcons.smile),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (c) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          height: double.infinity,
                          color: Colors.black.withOpacity(0.5),
                          child: ListView(
                            padding: EdgeInsets.all(20),
                            children: [StickerComponent()],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.brush_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.text_fields_rounded),
                onPressed: () {},
              ),
            ],
          ),
          backgroundColor: Colors.black,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MatrixGestureDetector(
                    clipChild: false,
                    shouldRotate: true,
                    shouldTranslate: false,
                    focalPointAlignment: Alignment.center,
                    onMatrixUpdate: (m, c, a, b) =>
                        controller.onUpdateCurrentImage(m),
                    child: Transform(
                      transform: controller.currentImage,
                      child: ImageNetwork(
                        src: img,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  ...List.generate(
                    controller.items.length,
                    (index) {
                      final item = controller.items[index];
                      final type = item.type;

                      if (type == ItemType.sticker) {
                        final sticker = item.sticker;

                        if (sticker?.type == StickerType.hours) {
                          return ItemMomentComponent(
                            index: index,
                            child: HourMoment(),
                            position: item.position!,
                            onChangePosition: (m) {
                              controller.onUpdateItemPosition(index, m);
                            },
                          );
                        }

                        if (sticker?.type == StickerType.music) {
                          return ItemMomentComponent(
                            index: index,
                            child: MusicCardMoment(music: sticker!.music!),
                            position: item.position!,
                            onChangePosition: (m) {
                              controller.onUpdateItemPosition(index, m);
                            },
                          );
                        }

                        if (sticker?.type == StickerType.sticker) {
                          return ItemMomentComponent(
                            index: index,
                            child: SvgPicture.asset(sticker?.path ?? ''),
                            position: item.position!,
                            onChangePosition: (m) {
                              controller.onUpdateItemPosition(index, m);
                            },
                          );
                        }

                        return Container();
                      }
                      return Container();
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      opacity: controller.showDelete ? 1 : 0,
                      duration: Duration(milliseconds: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: controller.largerDelete ? 80 : 50,
                            height: controller.largerDelete ? 80 : 50,
                            decoration: BoxDecoration(
                              color: controller.largerDelete
                                  ? Colors.redAccent
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              FeatherIcons.trash,
                              color: controller.largerDelete
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Publicar'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
