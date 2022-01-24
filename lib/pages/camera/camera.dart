import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:spalhe/controllers/moments/moments.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return GetBuilder<MomentsController>(
      init: MomentsController(),
      builder: (_) => Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: Transform.scale(
                scale: _.cameraIsRead
                    ? _.cameraController.value.aspectRatio / deviceRatio
                    : 1,
                child: _.cameraIsRead
                    ? AspectRatio(
                        aspectRatio: _.cameraController.value.aspectRatio,
                        child: CameraPreview(_.cameraController))
                    : Container(),
              ),
            ),
            SafeArea(
              child: Positioned(
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          FeatherIcons.x,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      InkWell(
                        onTap: _.getImage,
                        child: const Icon(
                          FeatherIcons.grid,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _.changeCamera,
                      child: const Icon(
                        FeatherIcons.repeat,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: _.camCaptureImage,
                      onLongPressEnd: (details) => _.camRecordStop(),
                      child: const Icon(
                        FeatherIcons.circle,
                        color: Colors.white,
                        size: 70.0,
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        FeatherIcons.zap,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: 0.0,
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
