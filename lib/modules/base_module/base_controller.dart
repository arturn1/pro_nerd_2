import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/data/user.dart';
import '../../core/utils/enums.dart';
import '../../core/values/constants.dart';
import '../../routes/pages.dart';

class BaseController extends GetxController {
  late Rx<User?> _user;

  UserModel? get userModel => _userModel.value;

  var userClasses = [].obs;

  setClasses(var v) => userClasses.value = v;

  final Rx<UserModel?> _userModel = const UserModel().obs;

  setUser(UserModel? value) => _userModel.value = value;

  final RxBool isExtend = false.obs;

  setIsExtend(v) => isExtend.value = v;

  @override
  void onInit() {
    super.onInit();
     getThemeStatus();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.offAllNamed(Routes.login);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2500), () async {
        actualUser(await getUserFromDB());
        Get.offAllNamed(Routes.base);
      });
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    setPage(pagesEnum.Home);
  }

  actualUser(UserModel? user) {
    setUser(user);
    setClasses(user!.classes);
  }

  Future<UserModel> getUserFromDB() {
    var u = firestore
        .collection("users")
        .where("uid", isEqualTo: _user.value!.uid)
        .get()
        .then((value) => UserModel.fromSnap(value.docs.last));
    return u;
  }

  final RxInt _page = 0.obs;
  var pageController = PageController().obs;

  animateTo(int page) {
    if (pageController.value.hasClients) {
      pageController.value.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
      // pageController.value.jumpToPage(page);
      setPage(pagesEnum.values[page]);
    }
  }

  setPage(Enum pagesEnum) => _page.value = pagesEnum.index;

  int get page => _page.value;

  navigateToPage(int input) async {
    switch (input) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/post');
        break;
      case 2:
        Get.toNamed('/task');
        break;
    }
  }

  final RxBool _isLightTheme = false.obs;


  bool get isLightTheme => _isLightTheme.value;
  setIsLightTheme(bool value) => _isLightTheme.value = value;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    _isLightTheme.value = (await isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void dispose(){
    super.dispose();
    pageController.value.dispose();
  }
}
