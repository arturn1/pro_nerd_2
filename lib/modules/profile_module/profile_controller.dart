import 'package:get/get.dart';
import 'package:cam/modules/profile_module/profile_service.dart';

import '../../app/data/user.dart';
import '../../core/values/constants.dart';
import '../base_module/base_controller.dart';

class ProfilePageController extends GetxController with ProfileService {

  BaseController userController = Get.find();

  getUserDataByUID(String uid) async {
    var user = await firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    var url = "";
    url =  UserModel.fromSnap(user.docs.single).photoUrl;
    return url;
  }

}
