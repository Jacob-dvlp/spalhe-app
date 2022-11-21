import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardImageMusic extends StatelessWidget {
  final animation = EzAnimation(
    10.0,
    100.0,
    Duration(seconds: 20),
    context: Get.context!,
  );
  final animation2 = EzAnimation(
    10.0,
    100.0,
    Duration(seconds: 30),
    context: Get.context!,
  );

  CardImageMusic() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animation.start();
      animation.repeat();
      animation2.start();
      animation2.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Stack(
          children: [
            Transform.rotate(
              angle: animation.value,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(150),
                    topRight: Radius.circular(240),
                    bottomLeft: Radius.circular(220),
                    bottomRight: Radius.circular(180),
                  ),
                  color: Color(0xff0092ff),
                ),
              ),
            ),
            Transform.rotate(
              angle: animation.value,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(650),
                    topRight: Radius.circular(540),
                    bottomLeft: Radius.circular(420),
                    bottomRight: Radius.circular(980),
                  ),
                  color: Color(0xff4ac7b7),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: animation2,
              builder: (context, c) {
                return Transform.rotate(
                  angle: animation2.value,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(450),
                        topRight: Radius.circular(940),
                        bottomLeft: Radius.circular(920),
                        bottomRight: Radius.circular(980),
                      ),
                      color: Color(0xffa4a6f6),
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
