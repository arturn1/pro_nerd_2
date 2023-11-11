import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/pages.dart';
import '../../forgot_password_module/forgot_pass_controller.dart';

class LoginPageForgotPassWidget extends GetView<ForgotPassPageController> {
  const LoginPageForgotPassWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        onPressed: () => Get.toNamed(Routes.forgotPass),
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 1, color: Theme.of(context).colorScheme.onSurface),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Theme.of(context).colorScheme.background
        ),
        child: Text(
          'Esqueci a senha',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface
          ),
        ),
      ),
    );
  }
}
