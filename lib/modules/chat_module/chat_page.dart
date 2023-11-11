import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:cam/modules/chat_module/widget/chat_page_card_widget.dart';

import '../../app/data/chat.dart';
import '../../app/data/room.dart';
import '../../app/widgets/custom_header_widget.dart';
import '../../core/values/constants.dart';
import 'chat_controller.dart';

class ChatPage extends GetView<ChatPageController> {
  ChatPage({Key? key}) : super(key: key);

  final RoomModel roomModel = Get.arguments[0];
  final bool isFollowing = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.inversePrimary,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_rounded,
                    color: Theme.of(context).colorScheme.inverseSurface,),
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 20),
                CustomHeader(text: 'Chat  ${roomModel.name}')
              ]),
            ),
            StreamBuilder<List<ChatModel>>(
              stream: controller.getChatStream(roomModel.classId),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.all(kMarginDefault),
                      child: Center(
                          child: GFLoader(
                        type: GFLoaderType.android,
                            androidLoaderColor: AlwaysStoppedAnimation<Color>(kPrimaryColor40),
                      )),
                    );
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => ChatCardWidget(
                      chatModel: snapshot.data![index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: isFollowing
            ? SafeArea(
                child: Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            controller.userController.userModel!.photoUrl),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: Form(
                            key: controller.formKey,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (v) => controller.setMessage(v),
                              decoration: InputDecoration(
                                  hintText:
                                      '@${controller.userController.userModel!.userName}',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            controller.addMessageToClass(roomModel.classId),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: const Icon(Icons.send),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
