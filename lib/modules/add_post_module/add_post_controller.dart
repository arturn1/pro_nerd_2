import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../app/data/post.dart';
import '../../app/data/room.dart';
import '../../core/utils/image_picker.dart';
import '../../core/values/constants.dart';
import '../base_module/base_controller.dart';
import 'add_post_service.dart';

class AddPostController extends GetxController with AddPostService{
  @override
  void onInit() {
    super.onInit();
    classesList.bindStream(classStream());
  }

  BaseController userController = Get.find();

  Rx<List<RoomModel>> classesList = Rx<List<RoomModel>>([]);

  List<RoomModel> get classes => classesList.value;

  final RxString _description = ''.obs;

  setDescription(value) => _description.value = value;

  final RxString _classId = ''.obs;

  setClassId(value) => _classId.value = value;

  final RxString _className = ''.obs;

  setClassName(value) => _className.value = value;

  String get className => _className.value;

  Future<void> addPost(XFile? file) async {
    try {
      String photoUrl =
          await ImagePickerHelper().uploadImageToStorage(file!, true);

      String postId = const Uuid().v1();
      PostModel post = PostModel(
          postId: postId,
          commentLength: 0,
          description: _description.value,
          uid: userController.userModel!.uid,
          userName: userController.userModel!.userName,
          datePublished: DateTime.now(),
          postImageUrl: photoUrl,
          userPhotoURL: userController.userModel!.photoUrl,
          classId: _classId.value,
          className: _className.value);

      addPostToDB(post);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<RoomModel>> classStream() {
    return firestore
        .collection("rooms")
        .where("followers", arrayContains: userController.userModel!.uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<RoomModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(RoomModel.fromSnap(element));
      }
      return retVal;
    });
  }
}
