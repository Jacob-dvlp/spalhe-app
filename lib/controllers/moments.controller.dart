import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/components/layout/story_maker/story_maker.dart';
import 'package:spalhe/models/moment.model.dart';
import 'package:spalhe/models/moment_views.model.dart';
import 'package:spalhe/services/api.dart';
import 'package:spalhe/services/gql/hooks.dart';
import 'package:spalhe/services/gql/queries/moment.dart';
import 'package:spalhe/utils/routes.dart';

class MomentController extends GetxController {
  List<MomentModel>? moments;
  List<IMomentViews> momentViews = [];

  MomentController() {
    getMoments();
  }

  getMomentViews(momentId) async {
    try {
      final res = await useQuery(GET_MOMENT_VIEW, variables: {
        'id': momentId,
      });
      final data = res.data!['getMomentViews'] as List;
      momentViews = data.map((e) => IMomentViews.fromJson(e)).toList();
      update();
    } catch (e) {
      print(e);
    }
  }

  viewMoment(momentId) async {
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        momentViews.clear();
        update();
      });
      await useMutation(VIEW_MOMENT_MUTATION, variables: {
        'id': momentId,
      });
      await getMomentViews(momentId);
    } catch (e) {
      print(e);
    }
  }

  getMoments() async {
    try {
      final res = await useQuery(GET_MOMENTS_QUERY);
      List<MomentModel> list = [];
      final data = res.data?['getMoments'];
      for (int i = 0; data.length > i; i++) {
        list.add(MomentModel.fromJson(data[i]));
      }
      moments = list;
      update();
    } catch (e) {
      print(e);
    }
  }

  createMoment() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then(
      (file) async {
        final File editedFile = await OnRoute.push(StoryMaker(
          filePath: file!.path,
        ));
        try {
          dio.FormData formData = dio.FormData.fromMap({
            "files": await dio.MultipartFile.fromFile(
              editedFile.path,
              filename: 'moment',
            ),
          });
          await api.post('/moments', data: formData);
          getMoments();
        } catch (e) {}
      },
    );
  }
}
