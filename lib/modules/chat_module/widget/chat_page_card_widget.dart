import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/chat.dart';
import '../../../core/values/constants.dart';
import '../chat_controller.dart';

class ChatCardWidget extends GetView<ChatPageController> {
  const ChatCardWidget({Key? key, required this.chatModel}) : super(key: key);

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    Color IS_MINE_CONTAINER = kPrimaryColorContainer90;
    Color IS_MINE_LETTER = kOnPrimaryColorContainer10;

    Color CONTAINER = kSecondaryColorContainer90;
    Color LETTER = kOnSecondaryColorContainer10;

    return Container(
      margin: chatModel.uid == controller.userController.userModel!.uid
          ? const EdgeInsets.fromLTRB(60, 10, 10, 10)
          : const EdgeInsets.fromLTRB(10, 10, 60, 10),
      decoration: BoxDecoration(
        color: chatModel.uid == controller.userController.userModel!.uid
            ? IS_MINE_CONTAINER
            : CONTAINER,
        borderRadius: chatModel.uid == controller.userController.userModel!.uid
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10))
            : const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(kPaddingDefault / 1.5),
          child: Row(
            textDirection:
                chatModel.uid == controller.userController.userModel!.uid
                    ? TextDirection.rtl
                    : null,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kPaddingDefault / 3),
                child: CircleAvatar(
                  child: ClipOval(
                    child: SizedBox.expand(
                        child: CachedNetworkImage(
                      imageUrl: chatModel.userPhotoURL,
                      placeholder: (context, url) => const Center(
                        child: Icon(Icons.person),
                      ),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: chatModel.uid ==
                                controller.userController.userModel!.uid
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(
                            chatModel.uid ==
                                    controller.userController.userModel!.uid
                                ? 'Você'
                                : chatModel.userName,
                            style: context.textTheme.titleMedium?.copyWith(
                                color: chatModel.uid ==
                                        controller.userController.userModel!.uid
                                    ? IS_MINE_LETTER
                                    : LETTER),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        chatModel.message,
                        textAlign: chatModel.uid ==
                                controller.userController.userModel!.uid
                            ? TextAlign.end
                            : null,
                        style: TextStyle(
                            fontSize: 12,
                            color: chatModel.uid ==
                                    controller.userController.userModel!.uid
                                ? IS_MINE_LETTER
                                : LETTER),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
