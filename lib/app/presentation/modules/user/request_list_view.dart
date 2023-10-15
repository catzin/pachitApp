import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/colors.dart';
import 'controllers/request_list_controller.dart';

class RequestListview extends StatelessWidget {
  RequestListview({super.key});
  final requestListController = Get.find<RequestListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Solicitudes"),
      ),
    );
  }
}