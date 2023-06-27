import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'messages_controller.dart';

class PickingImageController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  File? imageTemporary;
  final Messages _messages = Messages();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }

  Future makePhoto() async {
    XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imageTemporary = File(photo!.path);
      notifyListeners();
      final storageRef = _storage.ref('chat').child('xaxa');
      final uploadTask = storageRef.putFile(imageTemporary!);
      final storageSnapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await storageSnapshot.ref.getDownloadURL();
      // print(imageUrl.toString());
      _messages.db.collection('messages').doc().set({'imageUrl': imageUrl});
    }
  }
}
