import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/components/avatar/avatar.dart';
import 'package:spalhe/controllers/posts/posts.dart';
import 'package:spalhe/pages/camera/camera.dart';
import 'package:spalhe/pages/moments/components/avatar.gradient.dart';
import 'package:flutter/material.dart';
import 'package:spalhe/pages/moments/moments.dart';
import 'package:get/get.dart';

class MomentList extends StatelessWidget {
  final PostsController _ = Get.put(PostsController());

  MomentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(FeatherIcons.camera),
              onPressed: () {
                Get.to(
                  const CameraPage(),
                  transition: Transition.noTransition,
                );
              },
            ),
            Row(
              children: List.generate(
                _.moments.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        UserMomentsPage(_.moments),
                        transition: Transition.fade,
                      );
                      _.addMomentView(_.moments[index]);
                    },
                    child: _.momentViews.contains(_.moments[index])
                        ? Avatar(
                            url: _.moments[index]['avatar'],
                            width: 45.0,
                            height: 45.0,
                          )
                        : AvatarGradient(
                            _.moments[index]['avatar'], 45.0, 45.0, false),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
