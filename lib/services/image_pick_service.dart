import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:petto_app/utils/utils.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final String path = image.path;
        final File file = File(path);
        return file;
      }
    } catch (e) {
      logger.e('IMAGE PICKER ERROR: $e');
      rethrow;
    }
    return null;
  }
}
