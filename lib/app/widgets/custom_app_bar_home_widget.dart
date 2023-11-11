import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../modules/base_module/base_controller.dart';
import '../../routes/pages.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBarWidget(
      {Key? key, this.preferredSize = const Size.fromHeight(100)})
      : super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {

    BaseController baseController = Get.find();

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20),
              child: InkWell(
                onTap: () => Get.toNamed(Routes.profile),
                radius: 30,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    baseController.userModel!.photoUrl
                  ),
                )
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 60.0, left: 80),
                child: Text(
                  'PRO NERD',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
