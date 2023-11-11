import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cam/modules/register_module/register_controller.dart';
import 'package:rive/rive.dart';

import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/custom_input_form_widget.dart';
import '../../app/widgets/loader_login_page_widget.dart';
import '../../app/widgets/logo_widget.dart';
import '../../core/values/constants.dart';
import '../../routes/pages.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            if (GetPlatform.isWeb) Container(height: 100),
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20),
              child: LogoWidget(),
            ),
            if (!GetPlatform.isWeb)
              Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.white,
                  child: const RiveAnimation.asset(
                      'assets/rive/1542-3018-party.riv')),
            Padding(
              padding: const EdgeInsets.all(kPaddingDefault),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormInputWidget(
                      icon: Icons.person,
                      title: 'Nome',
                      controller: (v) => controller.setNewName(v),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => controller.getNameError(v),
                    ),
                    const SizedBox(height: 5.0),
                    FormInputWidget(
                      icon: Icons.email,
                      title: 'E-mail',
                      controller: (v) => controller.setNewEmail(v),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => controller.getEmailError(v),
                    ),
                    const SizedBox(height: 5.0),
                    FormInputWidget(
                      locked: true,
                      icon: Icons.lock,
                      title: 'Senha',
                      controller: (v) => controller.setNewPassword(v),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => controller.getPasswordError(v),
                    ),
                    FormInputWidget(
                      locked: true,
                      icon: Icons.lock,
                      title: 'Repita sua senha',
                      controller: (v) => controller.setNewConfirmedPassword(v),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => controller.getConfirmPasswordError(v),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonWidget(
                text: 'Registrar',
                function: controller.enableRegisterButton()
                    ? () => Get.to(() => LoaderLoginPage(
                          getData: controller.registerUser(),
                          getBack: () => Get.toNamed(Routes.login),
                        ))
                    : () => controller.messageError(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                CustomButtonWidget(text: 'Voltar', function: () => Get.back()),
          ),
        ],
      ),
    );
  }
}
