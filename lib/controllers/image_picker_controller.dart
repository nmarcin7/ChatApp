import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickingImageController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? imageTemporary;

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }

  Future makePhoto() async {
    XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imageTemporary = File(photo!.path);
      notifyListeners();
    }
  }
}
