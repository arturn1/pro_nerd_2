import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../app/widgets/custom_bottom_drawer_widget.dart';
import '../../app/widgets/custom_snack_bar_widget.dart';
import '../../app/widgets/snack_bar_source_widget.dart';
import '../home_module/home_page.dart';
import '../home_module/widgets/post_widget/post_home_widget_controller.dart';
import '../post_module/post_page.dart';
import '../profile_module/profile_page.dart';
import '../task_module/task_page.dart';
import 'base_controller.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // return Scaffold(
    //   body: Container(
    //     color: Colors.red,
    //   ),
    // );



    PostHomeWidgetController postHomeWidgetController =
        Get.put(PostHomeWidgetController());

    final List<Widget> mainContents = [
      const HomePage(),
      const PostPage(),
      const TaskPage(),
      const ProfilePage()
    ];

    return Scaffold(
              appBar: AppBar(

                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('PRO NERD'),
                centerTitle: true,
              ),
              extendBody: true,
              body:
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      // transitionBuilder: (Widget child, Animation<double> animation) {
                      //   return ScaleTransition(scale: animation, child: child);
                      // },
                      child: mainContents[controller.page],
                    ),
                  ))
                ],
              ),
              // PageView.builder(
              //           physics: const NeverScrollableScrollPhysics(),
              //             itemCount: mainContents.length,
              //             scrollDirection: Axis.horizontal,
              //             controller: controller.pageController.value,
              //             itemBuilder: (context, position) {
              //               return mainContents[position];
              //             }),
              bottomNavigationBar: const AnimatedBottomDrawer(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                elevation: 4,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onTertiary
                ),
                onPressed: () =>
                controller.userModel!.classes.isNotEmpty
                    ? Get.bottomSheet(const SelectImageSourceSnackWidget())
                    :
                CustomSnack()
                        .buildCardInformation('Crie ou procure um grupo'),
              ));
  }
}
