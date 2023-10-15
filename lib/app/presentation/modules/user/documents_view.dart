import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import '../../shared/expanded_button.dart';
import '../../shared/text_app.dart';
import '../../shared/tittle_section.dart';
import '../../theme/colors.dart';
import 'controllers/documents_controller.dart';

class DocumentsView extends StatelessWidget {
  DocumentsView({super.key});

  final documentsController = Get.find<DocumentsController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Documentos"),
          backgroundColor: HexColor(AppColors.primaryOrange),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final result = await documentsController.getImages();
                  if (result) {
                    scaffoldMessenger.showSnackBar(SnackBar(
                      backgroundColor: HexColor(AppColors.primaryOrange),
                      content: const Center(
                          child: Text(
                        '¡Evidencia registrada!',
                        style: TextStyle(color: Colors.white),
                      )),
                    ));
                    Get.back();
                  }
                },
                child: const Icon(
                  LineIcons.fileUpload,
                  size: 100,
                ),
              ),
              const TextApp(
                  text: 'Sube una identificación',
                  fontSize: 15,
                  weight: FontWeight.w500,
                  color: Colors.black)
            ],
          ),
        ));
  }
}
