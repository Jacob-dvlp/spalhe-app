import 'dart:io';
import 'package:spalhe/pages/camera/editor/editor.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class MomentsController extends GetxController {
  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  ScreenshotController screenshotController = ScreenshotController();
  int cameraActive = 1;
  bool cameraIsRead = false;

  get cameraController => _cameraController;

  @override
  void onReady() async {
    super.onReady();
    await getCamera();
  }

  @override
  void onClose() {
    super.onClose();
    _cameraController.dispose();
  }

  void changeCamera() {
    cameraActive == 1 ? cameraActive = 0 : cameraActive = 1;
    update();
    getCamera();
  }

  Future getCamera() async {
    cameraIsRead = false;
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _cameraController =
          CameraController(cameras[cameraActive], ResolutionPreset.max);
      _cameraController.initialize().then((_) {
        cameraIsRead = true;
        update();
      });
    }
  }

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var image = File(pickedFile.path);
      update();
      Get.to(PhotoEditor(image: image));
    }
  }

  void camRecordStop() {
    if (_cameraController.value.isInitialized &&
        _cameraController.value.isRecordingVideo) {
      _cameraController.stopVideoRecording().then((value) => {});
    }
  }

  void camCaptureImage() async {}

  bool liked = false;
  void likeMoment(id) async {
    try {
      liked = true;
      update();
    } catch (e) {
      //
    }
  }

  void deleteMoment(id) async {
    try {
      //
    } catch (e) {
      //
    }
  }
}
