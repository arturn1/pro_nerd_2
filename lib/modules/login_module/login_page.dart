import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:cam/modules/login_module/widget/login_page_divider_widget.dart';
import 'package:cam/modules/login_module/widget/login_page_forgot_pass_widget.dart';
import 'package:cam/modules/login_module/widget/login_page_google_btn_widget.dart';


import '../../app/widgets/custom_input_form_widget.dart';
import '../../app/widgets/loader_login_page_widget.dart';
import '../../app/widgets/custom_button_widget.dart';
import '../../app/widgets/logo_widget.dart';
import '../../core/values/constants.dart';
import '../../routes/pages.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => constraints.maxWidth < 1000
                ? SingleChildScrollView(
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.all(kPaddingDefault),
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: LogoWidget(),
                          ),
                          SvgPicture.asset(
                            "assets/images/background.svg",
                            height: 250,
                          ),
                          const SizedBox(height: 60.0),
                          Form(
                            child: FormInputWidget(
                              icon: Icons.email,
                              title: 'E-mail',
                              controller: (v) => controller.setEmail(v),
                              validator: (value) =>
                                  controller.getEmailError(value),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          FormInputWidget(
                            icon: Icons.lock,
                            title: 'Senha',
                            locked: true,
                            controller: (v) => controller.setPassword(v),
                            validator: (value) =>
                                controller.getEmptyError(value),
                          ),
                          const SizedBox(height: 10.0),
                          const LoginPageForgotPassWidget(),
                          const SizedBox(height: 30.0),
                          Obx(
                            () => CustomButtonWidget(
                              text: 'Acessar',
                              function: controller.enableLoginButton()
                                  ? () => Get.offAll(() => LoaderLoginPage(
                                        getData: controller.loginUser(),
                                        getBack: () =>
                                            Get.toNamed(Routes.login),
                                      ))
                                  : () => controller.messageError(),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          const LoginPageGoogleBtnWidget(),
                          const SizedBox(height: 20.0),
                          const LoginPageDividerWidget(),
                          const SizedBox(height: 20.0),
                          CustomButtonWidget(
                            text: 'Criar conta',
                            function: () => {(Get.toNamed(Routes.register))},
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 460, maxWidth: 800),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(kPaddingDefault),
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: LogoWidget(),
                              ),
                              SvgPicture.asset(
                                "assets/images/background.svg",
                                height: 250,
                              ),
                              const SizedBox(height: 60.0),
                              Form(
                                child: FormInputWidget(
                                  icon: Icons.email,
                                  title: 'E-mail',
                                  controller: (v) => controller.setEmail(v),
                                  validator: (value) =>
                                      controller.getEmailError(value),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              FormInputWidget(
                                icon: Icons.lock,
                                title: 'Senha',
                                locked: true,
                                controller: (v) => controller.setPassword(v),
                                validator: (value) =>
                                    controller.getEmptyError(value),
                              ),
                              const LoginPageForgotPassWidget(),
                              const SizedBox(height: 40.0),
                              Obx(
                                () => CustomButtonWidget(
                                  text: 'Acessar',
                                  function: controller.enableLoginButton()
                                      ? () => Get.offAll(() => LoaderLoginPage(
                                            getData: controller.loginUser(),
                                            getBack: () =>
                                                Get.toNamed(Routes.login),
                                          ))
                                      : () => controller.messageError(),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              const LoginPageGoogleBtnWidget(),
                              const SizedBox(height: 20.0),
                              const LoginPageDividerWidget(),
                              const SizedBox(height: 20.0),
                              CustomButtonWidget(
                                text: 'Criar conta',
                                function: () =>
                                    {(Get.toNamed(Routes.register))},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }
}
