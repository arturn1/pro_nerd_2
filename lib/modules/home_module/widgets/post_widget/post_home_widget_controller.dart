import 'package:get/get.dart';
import 'package:cam/modules/home_module/widgets/post_widget/post_home_widget_service.dart';

import '../../../../app/data/post.dart';
import '../../../base_module/base_controller.dart';

class PostHomeWidgetController extends GetxController
    with PostHomeWidgetService {
  BaseController userController = Get.find();

  RxBool updateNavPosition = false.obs;

  setUpdateNavPosition(v) => updateNavPosition.value = v;

  @override
  void onInit() {
    super.onInit();
    postListByClassFromUser.bindStream(getPost());
    filteredPostList.bindStream(getPost());
    ever(userController.userClasses, _updatePostHome);
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

  _updatePostHome(v) async {
    postListByClassFromUser.value =
        await getPostClass(userController.userClasses);
  }

  void runPostFilter(DateTime? d) {
    List<PostModel> results = [];
    results = postListByClassFromUser.value
        .where((post) => post.datePublished.day == d!.day)
        .toList();

    filteredPostList.value = results;
  }

}
