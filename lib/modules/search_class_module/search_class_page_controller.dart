import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/search_class_module/search_class_page_service.dart';

import '../../app/data/room.dart';
import '../../core/values/constants.dart';

class SearchClassPageController extends GetxController with SearchClassService {
  @override
  void onInit() {
    super.onInit();
    _getRoomList.bindStream(listRoomFromUser());
    searchRoomInsensitive('');
  }

  TextEditingController inputController = TextEditingController();

  final Rx<List<RoomModel>> _filteredRoomList = Rx<List<RoomModel>>([]);
  final Rx<List<RoomModel>> _getRoomList = Rx<List<RoomModel>>([]);

  final RxString _search = ''.obs;

  String get search => _search.value;

  setSearch(value) => _search.value = value;

  final RxString _password = ''.obs;

  setPassword(v) => _password.value = v;

  String get password => _password.value;

  List<RoomModel> get searchedRoomList => _filteredRoomList.value;

  List<RoomModel> get getRoomList => _getRoomList.value;

  Stream<List<RoomModel>> listRoomFromUser() {
    try {
      return getRoomStream();
    } catch (e) {
      rethrow;
    }
  }

  String? getEmptyError(String? value) {
    if (value!.isEmpty) {
      return ('Campo Obrigatorio');
    } else {
      return null;
    }
  }

  searchRoomInsensitive(String typedUser) {
    if (typedUser.length == 7) {
      _filteredRoomList.bindStream(
          firestore.collection('rooms').snapshots().map((QuerySnapshot query) {
        List<RoomModel> results = [];
        for (var elem in query.docs) {
          var room = RoomModel.fromSnap(elem);
          if (room.classId.toLowerCase().substring(0, 7) ==
              typedUser.toLowerCase()) {
            results.add(room);
          }
        }
        return results;
      }));
    } else {
      _filteredRoomList.bindStream(firestore
          .collection('rooms')
          .orderBy("followers", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<RoomModel> results = [];
        for (var elem in query.docs) {
          var room = RoomModel.fromSnap(elem);
          if (room.name.toLowerCase().contains(typedUser.toLowerCase()) ||
              room.classId.toLowerCase().contains(typedUser.toLowerCase())) {
            if (room.isPrivate == false) {
              results.add(room);
            }
          }
        }
        return results;
      }));
    }
  }

  Future<bool> checkPassword(String pass, RoomModel roomModel) async {
    return Future.value(Crypt(roomModel.password).match(pass));
  }

  void reset() {
    setSearch('');
    setPassword('');
  }
}
