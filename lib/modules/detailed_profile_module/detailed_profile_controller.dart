import 'package:get/get.dart';

import '../../app/data/user.dart';
import '../base_module/base_controller.dart';
import '../profile_module/profile_service.dart';

class DetailedProfilePageController extends GetxController with ProfileService {
  BaseController userController = Get.find();

  @override
  void onInit(){
    super.onInit();
    updateUserId(snap.uid);
  }

  var snap = Get.arguments;

  final Rx<UserModel> _user = const UserModel().obs;

  UserModel get user => _user.value;

  Future<void> updateUserId(String uid) async {
    _user.value =  await getUserData(uid);
  }
}