import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../modules/add_post_module/add_post_service.dart';
import '../../modules/base_module/base_controller.dart';


class ImagePickerHelper with AddPostService {
  BaseController userController = Get.find();

  Future<XFile> getFromCamera(ImageSource imageSource) async {
    try {
      XFile? image;

      if (imageSource == ImageSource.camera) {
        image = await getFromCameraService();
      } else if (imageSource == ImageSource.gallery) {
        image = await getFromGalleryService();
      }

      if (image == null) {
        throw Exception('');
      }

      return image;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImageToStorage(XFile file, bool isPost)  {
    return  uploadImageToStorageService(
        file, isPost, userController.userModel);
  }
}
