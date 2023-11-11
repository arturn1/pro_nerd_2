import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cam/modules/task_module/widget/task_page_header_widget.dart';

import '../../../core/values/constants.dart';
import '../task_controller.dart';

class TaskPageHeaderSearchWidget extends GetView<TaskPageController> {
  const TaskPageHeaderSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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

        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          sizeCurve: Curves.easeIn,
          crossFadeState: controller.isSearching.isFalse
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: const Center(
              child: TaskPageHeaderWidget(text: 'Tarefas')
          ),
          secondChild: Container(
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: kMarginDefault, vertical: kMarginDefault / 4),
                height: 50,
                child: TextFormField(
                    controller: controller.textController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    onChanged: (v) => {
                          controller.runFilter(v),
                        },
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2.0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        //borderSide: BorderSide.none,
                      ),
                      //prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel_rounded,
                          color: Theme.of(context).colorScheme.onSurface,
                          size: Theme.of(context).iconTheme.size,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.resetSearch();
                          controller.runFilter('');
                          controller.setIsSearching(false);
                          controller.textController.clear();
                        },
                      ),
                      hintText: 'Pesquisar ...',
                    )),
              )),
        ),
      ),
    );
  }
}
