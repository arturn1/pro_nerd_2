import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/constants.dart';
import '../../../../routes/pages.dart';
import '../../../add_class_room_module/add_class_room_page.dart';
import 'class_home_card_widget.dart';
import 'class_home_widget_controller.dart';

class ClassHomeWidget extends GetView<ClassHomeWidgetController> {
  const ClassHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.inversePrimary,
            blurRadius: 15,
            spreadRadius: 15,
            offset: const Offset(
              0,
              -50,
            ),
          ),
        ],
      ),
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Text(
                  'Meus grupos',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall?.fontSize,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10),
                child: IconButton(
                  onPressed: () => Get.bottomSheet(
                      const ClassRoomBottomSheetPage(message: 'Novo grupo')),
                  icon: Icon(
                    Icons.add_circle,
                    size: 18,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  color: kOnPrimaryColorContainer10,
                ),
              )
            ],
          ),
          GetX<ClassHomeWidgetController>(
              init: Get.put(ClassHomeWidgetController()),
              builder: (ClassHomeWidgetController controller) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.classListByUser.value.isEmpty
                        ? 1
                        : controller.classListByUser.value.length + 1,
                    itemBuilder: (_, index) => (index == 0)
                        ? GestureDetector(
                            onTap: () => Get.toNamed(Routes.searchClass),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary,
                                      size: Theme.of(context).iconTheme.size,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Procurar grupo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.fontSize,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  )
                                ],
                              ),
                            ),
                          )
                        : ClassesHomeCardWidget(
                            roomModel:
                                controller.classListByUser.value[index - 1]),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
