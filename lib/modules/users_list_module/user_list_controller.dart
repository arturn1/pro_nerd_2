import 'package:get/get.dart';
import 'package:cam/modules/users_list_module/user_list_service.dart';

import '../../app/data/user.dart';

class UserListController extends GetxController with UserListService{

  var roomModel = Get.arguments;

  Stream<List<UserModel>> getUserStream() {
    try {
      return userStreamFromDB(roomModel);
    } catch (e) {
      rethrow;
    }
  }

}