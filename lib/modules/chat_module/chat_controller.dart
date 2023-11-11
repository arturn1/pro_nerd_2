import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../app/data/chat.dart';
import '../base_module/base_controller.dart';
import 'chat_service.dart';

class ChatPageController extends GetxController with ChatService {
  BaseController userController = Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString uidTo = ''.obs;

  setClassId(value) => uidTo.value = value;

  final RxString message = ''.obs;

  setMessage(value) => message.value = value;

  Stream<List<ChatModel>> getChatStream(String chatId) {
    return chatStreamFromDB(chatId);
  }

  Future<void> addMessageToClass(String classId) async {
    if (message.isNotEmpty) {
      String id = const Uuid().v1();
      ChatModel chatModel = ChatModel(
          id: id,
          classId: classId,
          dateCreated: DateTime.now(),
          uid: userController.userModel!.uid,
          userName: userController.userModel!.userName,
          userPhotoURL: userController.userModel!.photoUrl,
          message: message.value);

      addChatFromDB(chatModel);
      reset();
      formKey.currentState!.reset();
    }
  }

  void reset() {
    setMessage('');
  }
}
