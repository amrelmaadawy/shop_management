import 'dart:io' show File;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageServices {
  static final picker = ImagePicker();
  static Future<XFile?> pickImageFromGalary() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  static Future<String> saveImageIntoAppDirectory(XFile image) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = path.basename(image.path);
    final savedImage = await File(image.path).copy('${dir.path}/$name');
    return savedImage.path;
  }
}
