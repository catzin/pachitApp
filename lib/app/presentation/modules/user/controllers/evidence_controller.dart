
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pachitaapp/app/domain/repositories/index.dart';

import '../../../../domain/models/evidenceResponse.dart';

class EvidenceController extends GetxController{

  final UserRepository userRepository;
  RxBool verifyResidence = false.obs;
  RxBool uploadImages = false.obs;
  RxList<Result> residenceEvidence = <Result>[].obs;
  final ImagePicker picker = ImagePicker();
  final List<String> paths = [];
  

  EvidenceController({required this.userRepository});

  @override
  void onInit(){
    super.onInit();
    existResidence();
  }


  void existResidence()async{

    try{
      verifyResidence.value = true;

      final EvidenceResponse flag = await userRepository.verifyResidenceEvidence();
      residenceEvidence.addAll(flag.result);
      verifyResidence.value = false;

    }catch(e){
      verifyResidence.value = false;
      Get.snackbar('!Upppps!', e.toString());
    }

  }

  void reTake(){
    residenceEvidence.value = [];
  }

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
