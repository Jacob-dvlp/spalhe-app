import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:spalhe/components/layout/image/image.dart';
import 'package:spalhe/pages/create_moment/components/hours/hours.dart';
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
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black.withOpacity(0.5),
                        child: ListView(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.addItem(ItemMoment(
                                  sticker: Sticker(
                                    name: 'hours',
                                    type: StickerType.hours,
                                  ),
                                  position: Matrix4.identity(),
                                  type: ItemType.sticker,
                                ));
                              },
                              child: HourMoment(),
                            ),
                          ],
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
                alignment: Alignment.center,
                children: [
                  MatrixGestureDetector(
                    clipChild: true,
                    shouldRotate: true,
                    shouldTranslate: true,
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
                          return MatrixGestureDetector(
                            shouldRotate: true,
                            shouldTranslate: true,
                            clipChild: true,
                            focalPointAlignment: Alignment.center,
                            onMatrixUpdate: (m, tm, sm, rm) {
                              controller.onUpdateItemPosition(index, m);
                            },
                            child: Transform(
                              transform: item.position!,
                              child: HourMoment(),
                            ),
                          );
                        }

                        return Container();
                      }
                      return Container();
                    },
                  )
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
