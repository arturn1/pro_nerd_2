import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../app/data/post.dart';
import '../../../../core/utils/verify_data.dart';
import '../../../../routes/pages.dart';
import '../../../post_module/widget/post_home_detailed_widget.dart';

class PostHomeCardWidget extends StatelessWidget {
  final PostModel snap;

  const PostHomeCardWidget({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Stack(children: [
            SizedBox(
              height: 186,
              width: 280,
              child: GestureDetector(
                onTap: () =>
                    Get.to(() => PostHomeDetailedWidget(), arguments: snap),
                child: Hero(
                  tag: snap.datePublished.toString(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
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
              top: 20,
              left: 20,
              child: SizedBox(
                height: 38,
                width: 38,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(snap.userPhotoURL),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 45,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snap.className,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontSize,
                        ),
                      ),
                      Text(
                        DatePickerHelper.instance
                            .showDateLikeInsta(snap.datePublished),
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.fontSize,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        Get.toNamed(Routes.comments, arguments: snap.postId),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.comment,
                            size: 25,
                          ),
                          const Spacer(),
                          Text(snap.commentLength.toString())
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
