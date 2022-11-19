import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spalhe/pages/create_moment/components/stickers/components/hours/hours.dart';
import 'package:spalhe/pages/create_moment/components/stickers/components/music/music_moment.dart';
import 'package:spalhe/pages/create_moment/components/stickers/list_stickers/stickers.dart';
import 'package:spalhe/pages/create_moment/controller/create_moment.controller.dart';
import 'package:spalhe/pages/create_moment/models/item_moment.model.dart';

class StickerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMomentController>(
      init: CreateMomentController(),
      builder: (controller) {
        return Container(
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              ...List.generate(
                ListStickers.length,
                (index) {
                  final item = ListStickers[index];

                  if (item.type == StickerType.music) {
                    return InkWell(
                      onTap: () {},
                      child: MusicMoment(),
                    );
                  }

                  if (item.type == StickerType.hours) {
                    return InkWell(
                      onTap: () {
                        controller.addItem(ItemMoment(
                          sticker: item,
                          position: Matrix4.identity(),
                          type: ItemType.sticker,
                        ));
                      },
                      child: HourMoment(),
                    );
                  }

                  return InkWell(
                    onTap: () {
                      controller.addItem(ItemMoment(
                        sticker: item,
                        position: Matrix4.identity(),
                        type: ItemType.sticker,
                      ));
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.all(5),
                      child: SvgPicture.asset(item.path!),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
