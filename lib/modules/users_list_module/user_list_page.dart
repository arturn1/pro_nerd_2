import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:cam/modules/users_list_module/user_list_controller.dart';
import 'package:cam/modules/users_list_module/widget/user_list_card_widget.dart';

import '../../app/data/user.dart';
import '../../app/widgets/custom_header_widget.dart';
import '../../core/values/constants.dart';

class UserListPage extends GetView<UserListController> {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                color: Theme.of(context).colorScheme.inversePrimary,
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back_rounded,
                      color: Theme.of(context).colorScheme.inverseSurface,),
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const CustomHeader(text: 'Usuários')
                ]),
              ),
            ),
            StreamBuilder<List<UserModel>>(
              stream: controller.getUserStream(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.all(kMarginDefault),
                      child: Center(
                          child: GFLoader(
                        type: GFLoaderType.android,
                            androidLoaderColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      )),
                    );
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => UserCard(
                      snap: snapshot.data![index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
