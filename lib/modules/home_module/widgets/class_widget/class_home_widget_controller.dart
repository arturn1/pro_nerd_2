import 'package:get/get.dart';


import '../../../../app/data/room.dart';
import '../../../base_module/base_controller.dart';
import 'class_home_widget_service.dart';

class ClassHomeWidgetController extends GetxController with ClassHomeWidgetService {

  BaseController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    classListByUser.bindStream(getClass());
  }

  Rx<List<RoomModel>> classListByUser = Rx<List<RoomModel>>([]);

  Stream<List<RoomModel>> getClass() {
    try{
      return getClassByUser(userController.userModel);
    }
    catch(e){
      rethrow;
    }
  }

}