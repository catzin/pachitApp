import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../global_controllers/global_controller.dart';
// ignore: unused_import
import '../../routes/routes.dart';
import '../../theme/colors.dart';
import 'request_org_view.dart';
// ignore: unused_import
import 'request_user_view.dart';

class RequestView extends StatelessWidget {
  RequestView({super.key});
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        color: HexColor(AppColors.white),
        child: Obx(
          () => globalController.isShelter.value == true
              ? RequestOrgView()
              : RequestUserView()
        ));
  }
}
