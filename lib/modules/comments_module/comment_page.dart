import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:cam/modules/comments_module/widgets/comment_card_widget.dart';

import '../../app/data/comment.dart';
import '../../app/widgets/custom_header_widget.dart';
import '../../core/values/constants.dart';
import 'comment_controller.dart';

class CommentsPage extends GetView<CommentController> {
  CommentsPage({Key? key}) : super(key: key);

  final String postId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                const CustomHeader(text: 'Comentários')
              ]),
            ),
            StreamBuilder<List<CommentModel>>(
              stream: controller.getCommentStream(postId),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.all(kMarginDefault),
                      child: Center(
                          child: GFLoader(
                        type: GFLoaderType.android,
                        androidLoaderColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor40),
                      )),
                    );
                  }
                }
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => CommentCard(
                      snap: snapshot.data![index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // text input
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surfaceVariant,
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(controller.userController.userModel!.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (v) => controller.setComment(v),
                      decoration: InputDecoration(
                          hintText:
                              '@${controller.userController.userModel!.userName}',
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.addComment(postId),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
