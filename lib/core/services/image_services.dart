import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageServices {
  static final picker = ImagePicker();
  static bool isPicking = false;
  static Future<XFile?> pickImageFromGalary() async {
    if (isPicking) return null;
    try {
      isPicking = true;
      return await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return null;
    } finally {
      isPicking = false;
    }
  }

  static Future<String> saveImageIntoAppDirectory(XFile image) async {
    final dir = await getApplicationDocumentsDirectory();
    final name = path.basename(image.path);
    final savedImage = await File(image.path).copy('${dir.path}/$name');
    return savedImage.path;
  }
}
