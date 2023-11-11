import 'package:crypt/crypt.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


import '../../app/data/room.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import '../base_module/base_controller.dart';
import 'add_class_room_service.dart';

class AddClassRoomController extends GetxController with AddClassRoomService {
  BaseController userController = Get.find();

  final RxString _name = ''.obs;

  String get name => _name.value;

  setName(value) => _name.value = value;

  final RxBool isPrivate = false.obs;

  final RxString _password = ''.obs;

  setPassword(v) => _password.value = v;

  String get password => _password.value;

  Future<void> addClass() async {
    String classId = const Uuid().v1();
    List<dynamic> uids = ([userController.userModel!.uid]);
    RoomModel roomModel = RoomModel(
        classId: classId,
        password: cryptPassword(),
        isPrivate: isPrivate.value,
        name: _name.value,
        uid: userController.userModel!.uid,
        userName: userController.userModel!.userName,
        dateCreated: DateTime.now(),
        followers: uids);

    await addClassToDB(roomModel);
    userController.userClasses.add(classId);
  }

  Future<void> editClass(String classId) async {

    await editClassToDB(name, cryptPassword(), isPrivate.value, classId);
    userController.userClasses.add(classId);
  }

  String cryptPassword() {
    String hashedPassword;
    return hashedPassword = Crypt.sha256(password).toString();
  }

  Future messageError() async {
    CustomSnack().buildCardError('Preecha todos os campos');
    return null;
  }

  String? getEmptyError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else {
      return null;
    }
  }

  bool canCreate() {
    if (name.isNotEmpty) {
      if (isPrivate.isTrue) {
        if (password.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
