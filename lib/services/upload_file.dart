import 'package:flutter/widgets.dart';
import 'package:image_picker_web/image_picker_web.dart';

class UploadService {
  Future<Image?> run() async {
    final imageFile = await ImagePickerWeb.getImageAsWidget();
    return imageFile;
  }
}
