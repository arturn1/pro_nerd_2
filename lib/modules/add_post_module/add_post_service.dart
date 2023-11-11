import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../app/data/post.dart';
import '../../app/data/user.dart';
import '../../core/values/constants.dart';

mixin AddPostService {
  Future<void> addPostToDB(PostModel postModel) async {
    try {
      firestore
          .collection('posts')
          .doc(postModel.postId)
          .set(postModel.toJson());
    } catch (err) {
      rethrow;
    }
  }

  Future<XFile?> getFromCameraService() async {
    final pickedFile =
    (await ImagePicker().pickImage(source: ImageSource.camera));
    final XFile image = XFile(pickedFile!.path);
    return image;
  }

  Future<XFile?> getFromGalleryService() async {
    try {
      final XFile? pickedFile =
      (await ImagePicker().pickImage(source: ImageSource.gallery));
      final XFile image = XFile(pickedFile!.path);

      return image;
    } on Exception catch (e) {
      rethrow;
    }
  }

  chooseImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    Reference _reference = firebaseStorage
        .ref()
        .child('posts')
        .child('userController.userModel!.uid');
    await _reference
        .putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        String uploadedPhotoUrl = value;
        return uploadedPhotoUrl;
      });
    });
  }

  Future<String> uploadImageToStorageService(
      XFile file, bool isPost, UserModel? userModel) async {
    Reference ref = firebaseStorage.ref().child('posts').child(userModel!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(await file.readAsBytes());
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
