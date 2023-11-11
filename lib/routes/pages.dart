import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../modules/add_post_module/add_post_controller.dart';
import '../modules/add_post_module/add_post_page.dart';
import '../modules/chat_module/chat_controller.dart';
import '../modules/chat_module/chat_page.dart';
import '../modules/class_room_module/class_room_controller.dart';
import '../modules/class_room_module/class_room_page.dart';
import '../modules/comments_module/comment_controller.dart';
import '../modules/comments_module/comment_page.dart';
import '../modules/detailed_profile_module/detailed_profile_controller.dart';
import '../modules/detailed_profile_module/detailed_profile_page.dart';
import '../modules/base_module/base_view.dart';
import '../modules/forgot_password_module/forgot_pass_controller.dart';
import '../modules/forgot_password_module/forgot_pass_page.dart';
import '../modules/login_module/login_controller.dart';
import '../modules/login_module/login_page.dart';
import '../modules/post_module/post_controller.dart';
import '../modules/post_module/post_page.dart';
import '../modules/post_module/widget/post_detailed_widget.dart';
import '../modules/profile_module/profile_controller.dart';
import '../modules/profile_module/profile_page.dart';
import '../modules/register_module/register_controller.dart';
import '../modules/register_module/register_page.dart';
import '../modules/search_class_module/search_class_page.dart';
import '../modules/search_class_module/search_class_page_controller.dart';
import '../modules/splash_screen_module/splash_screen_page.dart';
import '../modules/task_module/task_controller.dart';
import '../modules/task_module/task_page.dart';
import '../modules/users_list_module/user_list_controller.dart';
import '../modules/users_list_module/user_list_page.dart';

part './routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.base,
      page: () => const BaseView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
        name: Routes.comments,
        page: () => CommentsPage(),
        binding: BindingsBuilder(
            () => Get.lazyPut<CommentController>(() => CommentController()))),
    GetPage(
        name: Routes.classRoom,
        page: () => ClassRoomPage(),
        binding: BindingsBuilder(() => Get.lazyPut<ClassRoomPageController>(
            () => ClassRoomPageController()))),
    GetPage(
        name: Routes.post,
        page: () => const PostPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(
            () => Get.lazyPut<PostPageController>(() => PostPageController()))),
    GetPage(
        name: Routes.addPost,
        page: () => AddPostPage(),
        binding: BindingsBuilder(
            () => Get.lazyPut<AddPostController>(() => AddPostController()))),
    GetPage(
        name: Routes.task,
        page: () => const TaskPage(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(
            () => Get.lazyPut<TaskPageController>(() => TaskPageController()))),
    GetPage(
        name: Routes.profile,
        page: () => const ProfilePage(),
        binding: BindingsBuilder(() =>
            Get.lazyPut<ProfilePageController>(() => ProfilePageController()))),
    GetPage(
        name: Routes.detailedProfile,
        page: () => const DetailedProfilePage(),
        binding: BindingsBuilder(() =>
            Get.lazyPut<DetailedProfilePageController>(
                () => DetailedProfilePageController()))),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(() =>
            Get.lazyPut<LoginPageController>(() => LoginPageController()))),
    GetPage(
        name: Routes.register,
        page: () => const RegisterPage(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(() => Get.lazyPut<RegisterPageController>(
            () => RegisterPageController()))),
    GetPage(
        name: Routes.forgotPass,
        page: () => const ForgotPassPage(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(() => Get.lazyPut<ForgotPassPageController>(
            () => ForgotPassPageController()))),
    GetPage(
        name: Routes.chat,
        page: () => ChatPage(),
        binding: BindingsBuilder(
            () => Get.lazyPut<ChatPageController>(() => ChatPageController()))),
    GetPage(
        name: Routes.usersList,
        page: () => const UserListPage(),
        binding: BindingsBuilder(
            () => Get.lazyPut<UserListController>(() => UserListController()))),
    GetPage(name: Routes.detailedPost, page: () => PostDetailedWidget()),
    GetPage(name: Routes.splash, page: () => const SplashScreenPage()),
    GetPage(
        name: Routes.searchClass,
        page: () => const SearchClassPage(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        binding: BindingsBuilder(() => Get.lazyPut<SearchClassPageController>(
            () => SearchClassPageController()))),
  ];
}
