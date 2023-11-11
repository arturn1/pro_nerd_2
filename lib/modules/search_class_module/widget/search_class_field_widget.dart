import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/values/constants.dart';
import '../search_class_page_controller.dart';

class SearchClassSearchField extends GetView<SearchClassPageController> {
  const SearchClassSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.all(kMarginDefault),
      height: 45,
      child: TextFormField(
          controller: controller.inputController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
          ],
          onChanged: (v) => controller.searchRoomInsensitive(v),
          cursorColor: Colors.black,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurface,),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel_rounded, color: Theme.of(context).colorScheme.onSurface,),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  controller.reset();
                  controller.inputController.clear();
                  controller.searchRoomInsensitive('');
                },
              ),
              hintText: 'Pesquisar ...',)),
    );
  }
}
