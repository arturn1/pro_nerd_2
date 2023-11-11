import 'package:cached_network_image/cached_network_image.dart';
import 'package:cam/modules/post_module/widget/post_confirm_delete_action_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';


import '../../../app/data/post.dart';
import '../../../core/utils/verify_data.dart';
import '../../../core/values/constants.dart';
import '../../../routes/pages.dart';
import '../post_controller.dart';

class PostCardWidget extends GetView<PostPageController> {
  const PostCardWidget({required this.snap, Key? key}) : super(key: key);

  final PostModel snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .36,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer),
      margin: const EdgeInsets.all(kMarginDefault),
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              height: pixelDevice == 3 ? Get.height * .25 : Get.height * .28,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => Get.toNamed(Routes.detailedPost, arguments: snap),
                child: Hero(
                  tag: snap.postId,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )),
                      fit: BoxFit.cover,
                      imageUrl: snap.postImageUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10, // SizedBox(
              child: FittedBox(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(snap.userPhotoURL),
                ),
              ),
            ),
            if (controller.userController.userModel!.uid == snap.uid)
              Positioned(
                top: 10,
                right: 10, // SizedBox(
                child: Material(
                  elevation: 3,
                  shape: const CircleBorder(),
                  child: InkWell(
                      onTap: () async => CustomDeleteDialog(context: context)
                          .buildDeleteConfirmation(snap.postId),
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onTertiary,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: Theme.of(context).iconTheme.size,
                        ),
                      )),
                ),
              ),
            Positioned(
              top: controller.userController.userModel!.uid == snap.uid
                  ? 55
                  : 10,
              right: 10, // SizedBox(
              child: Material(
                elevation: 3,
                shape: const CircleBorder(),
                child: InkWell(
                    onTap: () async => {
                          DefaultCacheManager()
                              .getSingleFile(snap.postImageUrl)
                              .then((v) =>
                                  controller.files.add(controller.convert(v)))
                              .then((value) => Share.shareXFiles(
                                  controller.files,
                                  subject: 'Compartilhei'))
                              .then((value) => controller.files
                                  .removeRange(0, controller.files.length)),
                        },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onTertiary,
                      child: Icon(
                        Icons.share,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    )),
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: kMarginDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      snap.className,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      DatePickerHelper.instance
                          .showDateLikeInsta(snap.datePublished),
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleSmall?.fontSize,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: kMarginDefault),
                height: 140,
                child: TextButton.icon(
                    icon: Icon(
                      Icons.comment,
                      size: Theme.of(context).iconTheme.size,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: kOnPrimaryColorContainer10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    onPressed: () =>
                        Get.toNamed(Routes.comments, arguments: snap.postId),
                    label: Text(
                      snap.commentLength.toString(),
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    )),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
