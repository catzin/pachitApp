import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pachitaapp/app/domain/repositories/user_repository.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

import '../../../../domain/models/incidencias.dart';

class SpendController extends GetxController {
  RxBool generating = false.obs;
  final idPet = Get.arguments;
  RxString petImage = "".obs;
  RxBool loadPicture = false.obs;
  RxBool loadIncidence = false.obs;
  final UserRepository userRepository;
  RxList<Incidencia> incidencias = <Incidencia>[].obs;

  SpendController({required this.userRepository});

  @override
  void onInit() {
    super.onInit();
    getImage();
    getIncidences();
  }

  Future<Uint8List> downloadImage(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    var bytes = await file.readAsBytes();
    return bytes;
  }

  Future<void> saveAndOpenPdf() async {
  generating.value = true;
  final pdf = pw.Document();
  final imageBytes = await downloadImage(petImage.value);

  final fontData = await rootBundle.load('lib/app/presentation/assets/fonts/IBMPlexSans-SemiBoldItalic.ttf');
  final fontBytes = fontData.buffer.asUint8List();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: [
          pw.Image(pw.MemoryImage(imageBytes)),
          ...incidencias.map(
            (incidencia) => pw.Column(
              children: [
                pw.Text(
                  incidencia.descripcion,
                  style: pw.TextStyle(
                    font: pw.Font.ttf(ByteData.view(fontBytes.buffer)),
                  ),
                ),
                pw.Text(
                  '\$${incidencia.gasto.toString()}',
                  style: pw.TextStyle(
                    font: pw.Font.ttf(ByteData.view(fontBytes.buffer)),
                  ),
                ),
                pw.Text(
                  DateFormat('dd/MM/yyyy').format(incidencia.fechaCreacion),
                  style: pw.TextStyle(
                    font: pw.Font.ttf(ByteData.view(fontBytes.buffer)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  final pdfBytes = await pdf.save();
  generating.value = false;

  // Create a temporary file path
  final tempDir = await getTemporaryDirectory();
  final tempFilePath = '${tempDir.path}/example.pdf';

  // Save the PDF bytes to the temporary file
  final tempFile = File(tempFilePath);
  await tempFile.writeAsBytes(pdfBytes);

  // Open the PDF file with the PDF viewer
  Get.to(() => PDFView(
    filePath: tempFilePath,
  ));
}


Future<Uint8List> writeToFileAndGetFile(ByteData data) async {
  final tempDir = await getTemporaryDirectory();
  final fontFile = File('${tempDir.path}/tempFontFile.ttf');
  await fontFile.writeAsBytes(data.buffer.asUint8List());
  return await fontFile.readAsBytes();
}

 


  void getImage() async {
    try {
      loadPicture.value = true;
      petImage.value = await userRepository.getPetProfileImage(idPet);
      await Future.delayed(const Duration(seconds: 1));
      loadPicture.value = false;
    } catch (e) {
      loadPicture.value = false;
      e.printError();
    }
  }

  void getIncidences() async {
    try {
      loadIncidence.value = true;
      incidencias.value = await userRepository.listIncidences(idPet);
      loadIncidence.value = false;
    } catch (e) {
      loadIncidence.value = false;
      e.printError();
    }
  }
}
