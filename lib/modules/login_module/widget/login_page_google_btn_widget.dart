import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/loader_login_page_widget.dart';
import '../../../routes/pages.dart';
import '../login_controller.dart';

class LoginPageGoogleBtnWidget extends GetView<LoginPageController> {
  const LoginPageGoogleBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45.0,
        width: double.infinity,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            label: Text(
              'Google',
              style: TextStyle(fontSize: 18.0,
                color: Theme.of(context).colorScheme.onPrimary),
            ),
            icon: Icon(
              Icons.g_mobiledata,
              size: 25.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.to(
                  () => LoaderLoginPage(
                    getData: controller.signInWithGoogle(),
                    getBack: () => Get.toNamed(Routes.login),
                  ),
                )));
  }
}
