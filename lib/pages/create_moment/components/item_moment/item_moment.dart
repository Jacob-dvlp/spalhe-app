import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:spalhe/pages/create_moment/controller/create_moment.controller.dart';
import 'package:spalhe/utils/debouncer.dart';

class ItemMomentComponent extends StatelessWidget {
  final Widget child;
  final Matrix4 position;
  final Function(Matrix4) onChangePosition;

  final int index;

  const ItemMomentComponent({
    required this.child,
    required this.position,
    required this.onChangePosition,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 400);
    final debouncerStart = Debouncer(milliseconds: 100);
    final controller = Get.put(CreateMomentController());

    return Listener(
      behavior: HitTestBehavior.deferToChild,
      onPointerMove: (e) {
        debouncerStart.run(() {
          controller.changeShowDelete(true);
        });
        if (e.position.dy >= 700 &&
            e.position.dx >= 100 &&
            e.position.dx <= 300 &&
            e.position.direction > 0) {
          controller.changeLargerDelete(true);
        } else {
          controller.changeLargerDelete(false);
        }
      },
      onPointerUp: (e) {
        if (e.position.dy >= 700 &&
            e.position.dx >= 100 &&
            e.position.dx <= 300 &&
            e.position.direction > 0) {
          controller.removeItem(index);
          controller.changeLargerDelete(false);
        }

        debouncer.run(() {
          controller.changeShowDelete(false);
          controller.changeLargerDelete(false);
        });
      },
      child: MatrixGestureDetector(
        shouldRotate: true,
        shouldTranslate: true,
        clipChild: true,
        focalPointAlignment: Alignment.center,
        onMatrixUpdate: (m, tm, sm, rm) {
          final matrix = MatrixGestureDetector.compose(m, tm, sm, rm);
          onChangePosition(matrix);
        },
        child: Transform(
          transform: position,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
