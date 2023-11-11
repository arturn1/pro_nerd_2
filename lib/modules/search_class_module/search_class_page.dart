import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cam/modules/search_class_module/search_class_page_controller.dart';
import 'package:cam/modules/search_class_module/widget/search_class_card_widget.dart';
import 'package:cam/modules/search_class_module/widget/search_class_field_widget.dart';

import '../../app/widgets/custom_header_widget.dart';

class SearchClassPage extends GetView<SearchClassPageController> {
  const SearchClassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('PRO NERD'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary,
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: const Offset(
                    -0,
                    -50,
                  ),
                ),
              ],
            ),
            height: 40,
            child: const CustomHeader(text: 'Grupos'),
          ),
          Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    offset: const Offset(
                      0,
                      -1,
                    ),
                  ),
                ],
              ),
              child: const SearchClassSearchField()),
          GetX<SearchClassPageController>(
            init: Get.put<SearchClassPageController>(
                SearchClassPageController()),
            builder: (SearchClassPageController controller) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.searchedRoomList.length,
                  itemBuilder: (_, index) => SearchClassesSearchCard(
                    roomModel: controller.searchedRoomList[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
