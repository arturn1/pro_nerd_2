
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:cam/modules/search_class_module/widget/search_class_password_widget.dart';

import '../../../app/data/room.dart';
import '../../../core/utils/verify_data.dart';
import '../../../core/values/constants.dart';
import '../../../routes/pages.dart';
import '../../class_room_module/class_room_controller.dart';
import '../../profile_module/profile_controller.dart';

class SearchClassesSearchCard extends GetView<ClassRoomPageController> {
  const SearchClassesSearchCard({Key? key, required this.roomModel})
      : super(key: key);

  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    ProfilePageController profileController = Get.put(ProfilePageController());

    return InkWell(
      onTap: roomModel.isPrivate ?
      () => CustomPasswordDialog(context: context).buildPasswordConfirmation(roomModel)
          :
          () => {
        Get.toNamed(
          Routes.classRoom,
          arguments: roomModel,
        )
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 100),
                    decoration: BoxDecoration(
                      border:  Border.all(color: kOnPrimaryColorContainer10),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    height: 35,
                    child: Center(
                      child: Text(
                        roomModel.name,
                        maxLines: 1,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      roomModel.userName.length > 20 ?
                      'Criado por: ${roomModel.userName.substring(0,23)}' :
                      'Criado por: ${roomModel.userName}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Criado em: ' + DatePickerHelper.instance.showCorrectDate(roomModel.dateCreated),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        // color: Colors.red,
                        margin: const EdgeInsets.only(bottom: kMarginDefault / 2),
                        height: 40,
                        width: 130,
                        child: OverflowView.flexible(
                          direction: Axis.horizontal,
                          spacing: 4,
                          children: <Widget>[
                            for (int i = 0; i < roomModel.followers.length; i++)
                              FutureBuilder(
                                future: profileController
                                    .getUserDataByUID(roomModel.followers[i]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data),
                                    );
                                  }
                                  return const SizedBox(
                                      height: 30,
                                      child: GFLoader(
                                        type: GFLoaderType.custom,
                                        loaderIconOne: Icon(Icons.insert_emoticon),
                                      ));
                                },
                              ),
                          ],
                          builder: (context, remaining) {
                            return Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: kSecondaryColorContainer90,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                '+$remaining',
                                style:
                                    TextStyle(color: kOnSecondaryColorContainer10),
                              )),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
