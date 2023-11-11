import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';

import '../../app/widgets/loader_login_page_widget.dart';
import '../../routes/pages.dart';
import '../base_module/base_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseController authController = Get.find();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    authController.userModel!.photoUrl),
              ),
              SizedBox(
                height: 70,
                child: Center(
                  child: Text(
                    authController.userModel!.userName,
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: .05,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                ),
              ),
              // ProfileMenuWidget(
              //     text: "Novidades", press: () => Get.to(const WebViewPage())),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 15),
                                child: Text(
                                  'Configurações',
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.fontSize,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              )),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 10),
                                  child: Text(
                                    'Modo Escuro',
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.fontSize,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, bottom: 10),
                                  child: Obx(
                                        () => GFToggle(
                                      enabledThumbColor: Colors.white,
                                      enabledTrackColor: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      disabledTrackColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      value: authController.isLightTheme,
                                      onChanged: (val) {
                                        authController
                                            .setIsLightTheme(val!);
                                        Get.changeThemeMode(
                                          authController.isLightTheme
                                              ? ThemeMode.dark
                                              : ThemeMode.light,
                                        );
                                        authController.saveThemeStatus();
                                      },
                                      type: GFToggleType.ios,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: InkWell(
                              child: Center(
                                child: Text('Sair',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                  ),),
                              ),
                              onTap: () => Get.offAll(
                                  LoaderLoginPage(
                                      getData: authController.signOut(),
                                      getBack: () => Get.toNamed(Routes.base)
                                  )
                              )
                              ,
                            ),
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
              //   ProfileMenuWidget(
              //       text: "Sobre",
              //       icon: "assets/icons/FlashIcon.svg",
              //       press: () => Get.to(const WebViewPage())),
            ],
          ),
        ),
      ),
    );
  }
}
