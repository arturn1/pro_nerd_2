import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/data/chat.dart';
import '../../core/values/constants.dart';

mixin ChatService {
  Stream<List<ChatModel>> chatStreamFromDB(String chatId) {
    return firestore
        .collection('chats')
        .where('classId', isEqualTo: chatId)
        .orderBy("dateCreated")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(ChatModel.fromSnap(element));
      }
      return retVal.reversed.toList();
    });
  }

  Future<void> addChatFromDB(ChatModel chatModel) async {
    try {
      firestore
          .collection('chats')
          .doc(chatModel.id)
          .set(chatModel.toJson());
    } catch (err) {
      rethrow;
    }
  }

  void deleteChatFromDB(String id) {
    firestore
        .collection("chats")
        .doc(id)
        .delete();
  }
}
