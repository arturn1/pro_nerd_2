import 'dart:io';

import 'package:get/get.dart';
import 'package:cam/modules/post_module/post_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/data/post.dart';
import '../base_module/base_controller.dart';

class PostPageController extends GetxController with PostService {
  BaseController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    filteredPostList.bindStream(getPost());
    postListByClassFromUser.bindStream(getPost());
    ever(userController.userClasses, _updatePostPage);
  }

  Rx<List<PostModel>> postListByClassFromUser = Rx<List<PostModel>>([]);
  Rx<List<PostModel>> filteredPostList = Rx<List<PostModel>>([]);

  Stream<List<PostModel>> getPost() {
    try {
      return getPostClassByUser(userController.userClasses);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await deletePostFromDB(postId);
    } catch (err) {
      rethrow;
    }
  }

  final files = <XFile>[];

  XFile convert(File file){
    XFile newFile = XFile(file.path);
    return newFile;
  }


  //Search fields
  var isSearchingPostScreenFilter = false.obs;

  setIsSearchingPostScreenFilter() =>
      isSearchingPostScreenFilter.value = !isSearchingPostScreenFilter.value;

  setIsSearchingPostScreenFilterFalse() =>
      isSearchingPostScreenFilter.value = false;

  resetFilter() async {
    filteredPostList.value = await getPostClass(userController.userClasses);
  }

  _updatePostPage(v) async {
    filteredPostList.value = await getPostClass(userController.userClasses);
  }

  Future<void> runPostFilter(DateTime? d) async {
    if (d == null) {
      filteredPostList.value = await getPostClass(userController.userClasses);
    } else {
      List<PostModel> results = [];
      results = postListByClassFromUser.value
          .where((post) => post.datePublished.day == d!.day)
          .toList();

      filteredPostList.value = results;
    }
  }
}
