import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/shared/index.dart';
import 'package:signature/signature.dart';

import '../../../theme/colors.dart';
import '../controllers/signature_controller.dart';

class SignatureWidget extends StatefulWidget {
  const SignatureWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5, // Ancho del trazo del lápiz
    penColor: Colors.black, // Color del lápiz
    exportBackgroundColor: Colors.white, // Color de fondo de la imagen exportada
  );

  @override
  Widget build(BuildContext context) {

    final signatureController = Get.find<SignaturesController>();
    return Column(
      children: [
        Signature(
          controller: _controller,
          height: 200, // Altura del área de firma
          backgroundColor: HexColor(AppColors.blueLight), // Color de fondo del área de firma
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => signatureController.uploading.value
                    ? const Center(
                        child: CircularProgressIndicator( color: Colors.orangeAccent,),
                      )
                    :
                ExpandedButton(
                    text: const Text("Firmar"),
                    color: AppColors.primaryOrange,
                    textMode: false,
                  action: ()async{
                    if (_controller.isNotEmpty) {
                      try {
                        final signatureImage = await _controller.toPngBytes();
                        signatureController.signature(signatureImage!);
                      } catch (e) {
                        Get.snackbar('!Upss!', e.toString());
                      }
                    } else {
                    }
                  },
                ),
              ),

              ExpandedButton(
                  text: const Text("Cancelar"),
                  color: AppColors.cancel,
                  textMode: false,
                action: () {
                  _controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
