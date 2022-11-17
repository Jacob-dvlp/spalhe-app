import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:spalhe/models/ifile.model.dart';
import 'package:spalhe/services/api.dart';

class UploadController extends GetxController {
  Future<IFile?> upload(XFile file) async {
    dio.FormData formData = dio.FormData.fromMap({
      "files": await dio.MultipartFile.fromFile(
        file.path,
        filename: file.name,
      ),
    });
    try {
      final res = await api.post('/v1/upload/files', data: formData);
      return IFile.fromJson(res.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

getContentType(XFile file) {
  final ext = file.path.split('.').last;
  switch (ext) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    case 'mp4':
      return 'video/mp4';
    default:
      return 'image/jpeg';
  }
}
