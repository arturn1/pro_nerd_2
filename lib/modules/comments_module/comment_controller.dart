import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../app/data/comment.dart';
import '../base_module/base_controller.dart';
import 'comment_service.dart';

class CommentController extends GetxController with CommentService {
  BaseController userController = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<List<CommentModel>> commentList = Rx<List<CommentModel>>([]);

  final RxString _comment = ''.obs;

  setComment(value) => _comment.value = value;

  Future<void> addComment(String postId) async {
    if (_comment.isNotEmpty) {
      try {
        addCommentToDB(postId, userController.userModel, _comment.value);
        reset();
        formKey.currentState!.reset();
      } catch (e) {
        rethrow;
      }
    }
  }

  Stream<List<CommentModel>> getCommentStream(String postId) {
    try {
      return getCommentStreamFromDB(postId);
    } catch (e) {
      rethrow;
    }
  }

  void reset() {
    setComment('');
  }
}
