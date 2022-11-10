import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spalhe/components/layout/avatar/avatar.dart';
import 'package:spalhe/controllers/auth.controller.dart';
import 'package:spalhe/controllers/moments.controller.dart';
import 'package:spalhe/pages/stories/moments.dart';
import 'package:spalhe/theme/colors.dart';
import 'package:spalhe/utils/routes.dart';

class MomentsComponent extends StatelessWidget {
  MomentsComponent({Key? key}) : super(key: key);
  final _auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final user = _auth.auth.user!;
    return GetBuilder<MomentController>(
      init: MomentController(),
      builder: (_moment) {
        final moments = _moment.moments;

        return SizedBox(
          height: 60,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: primary, width: 2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _moment.createMoment();
                      },
                      child: Avatar(
                        user: user,
                        width: 60,
                        heigth: 60,
                        showIcon: false,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: primary,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ...List.generate(moments?.length ?? 0, (index) {
                return GestureDetector(
                  onTap: () => OnRoute.push(
                    MomentPage(moments: moments!, index: index),
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: primary, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Avatar(
                      user: user,
                      width: 60,
                      heigth: 60,
                      showIcon: false,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
