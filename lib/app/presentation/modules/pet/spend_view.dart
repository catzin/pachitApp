import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:intl/intl.dart';
import '../../theme/colors.dart';
import 'controllers/spend_controller.dart';

class SpendView extends StatelessWidget {
  SpendView({super.key});

  final spendController = Get.find<SpendController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(AppColors.blueAccent),
          title: const Text("Historial"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() {
                    if (spendController.loadPicture.value) {
                      return const CircularProgressIndicator();
                    } else {
                      String? imageUrl = spendController.petImage.value;

                      // ignore: unnecessary_null_comparison
                      if (imageUrl != null &&
                          imageUrl.isNotEmpty &&
                          Uri.parse(imageUrl).isAbsolute) {
                        return CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: CachedNetworkImageProvider(imageUrl),
                        );
                      } else {
                        return const CircleAvatar(
                          maxRadius: 50,
                          child: Icon(
                            Icons.error,
                          ),
                        );
                      }
                    }
                  }),
                  const TextApp(
                      text: "Histoial de gastos",
                      fontSize: 16,
                      weight: FontWeight.w500,
                      color: Colors.black),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 400,
                child: Obx(() {
                  if (spendController.incidencias.isNotEmpty) {
                    return ListView.builder(
                      itemCount: spendController.incidencias.length,
                      itemBuilder: (BuildContext context, int index) {
                        final incidencia = spendController.incidencias[index];
                        return ListTile(
                         
                          title: Text(incidencia
                              .descripcion),
                          trailing: Text('\$${incidencia.gasto.toString()}'),

                          subtitle: Text(DateFormat('dd/MM/yyyy').format(incidencia.fechaCreacion)),

                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No hay gastos disponibles.'),
                    );
                  }
                }),
              ),
              ExpandedButton(text: const Text("Generar PDF"), color: AppColors.primaryOrange, textMode: false, action: ()async{
                await spendController.saveAndOpenPdf();

              },
              )
            ],
          ),
        ));
  }
}
