import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:petto_app/utils/utils.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        return image;
      }
    } catch (e) {
      logger.e('IMAGE PICKER ERROR: $e');
    }
    return null;
  }
}
