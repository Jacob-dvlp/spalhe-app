import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/components/layout/story_maker/story_maker.dart';
import 'package:spalhe/controllers/moment.model.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/utils/routes.dart';

class MomentController extends GetxController {
  List<MomentsModel>? moments;

  MomentController() {
    getMoments();
  }

  getMoments() async {
    try {
      final res = await api.get('/moments');
      List<MomentsModel> list = [];
      for (int i = 0; res.data.length > i; i++) {
        list.add(MomentsModel.fromJson(res.data[i]));
      }
      moments = list;
      update();
    } catch (e) {
      print(e);
    }
  }

  createMoment() async {
    {
      final picker = ImagePicker();
      await picker.pickImage(source: ImageSource.gallery).then(
        (file) async {
          final File editedFile = await OnRoute.push(StoryMaker(
            filePath: file!.path,
          ));
          print(editedFile);
        },
      );
    }
  }
}
