import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/tittle_section.dart';

import '../../routes/routes.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/evidence_controller.dart';

class ResidenceView extends StatelessWidget {
  ResidenceView({super.key});

  final evidenceController = Get.find<EvidenceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Domicilio"),
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body: Obx(
        () => evidenceController.verifyResidence.value ||
                evidenceController.uploadImages.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              )
            : Center(
                child: evidenceController.residenceEvidence.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final result =
                                  await evidenceController.getImages();
                              if (result) {
                                scaffoldMessenger.showSnackBar(SnackBar(
                                  backgroundColor:
                                      HexColor(AppColors.primaryOrange),
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
                              text: 'Sube al menos 2 fotos de tu domicilio',
                              fontSize: 15,
                              weight: FontWeight.w500,
                              color: Colors.black)
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const TitleSection(
                                title: 'Evidencia domicilio',
                                subTitle: 'Mantente actualizado',
                                icon: LineIcons.home),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 400,
                              child: GridView.builder(
                                itemCount:
                                    evidenceController.residenceEvidence.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  final evidence = evidenceController
                                      .residenceEvidence[index];
                                  return GridTile(
                                      child: Card(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: evidence.path,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ));
                                },
                              ),
                            ),
                            ExpandedButton(
                              text: const Text("Tomar de nuevo"),
                              color: AppColors.primaryOrange,
                              textMode: false,
                              action: () {
                                evidenceController.reTake();
                              },
                            )
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
