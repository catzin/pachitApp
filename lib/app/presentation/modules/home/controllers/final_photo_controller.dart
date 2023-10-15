import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

class FinalPhotoController extends GetxController{
  final UserRepository userRepository;

  final ImagePicker picker = ImagePicker();
  final List<String> paths = [];
   RxBool uploadImages = false.obs;

  FinalPhotoController({required this.userRepository});

  Future<bool> getImages() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    // ignore: unnecessary_null_comparison
    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        paths.add(file.path);
      }

      if(paths.isNotEmpty){
        try{
        uploadImages.value = true;
        await userRepository.uploadResidenceEvidence(paths);
        uploadImages.value = false;
        return true;

      }catch(e){
    
        uploadImages.value = false;
        Get.snackbar('!Uppps!', e.toString());
        return false;
      }

      }

  
    }
    return false;

  }
}