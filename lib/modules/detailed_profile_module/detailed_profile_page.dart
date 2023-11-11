import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/widgets/custom_app_bar_widget.dart';
import 'detailed_profile_controller.dart';

class DetailedProfilePage extends GetView<DetailedProfilePageController> {
  const DetailedProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 31.0),
      child: Scaffold(
        appBar: const AppBarWidget(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: [
                  Obx(() => CachedNetworkImage(
                    imageUrl: controller.user.photoUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => const Icon(Icons.person, size: 80,),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 100,
                    child: Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Center(
                        child: Text(
                            controller.user.userName,
                            style: TextStyle(
                                fontSize:
                                    Theme.of(context).textTheme.headlineMedium?.fontSize,
                            color: Theme.of(context).colorScheme.onPrimary,),
                          ),
                      ),
                    ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
