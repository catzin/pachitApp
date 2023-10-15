import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/presentation/global_controllers/global_controller.dart';

import 'widgets/request_list.dart';

class RequestOrgView extends StatelessWidget {
  RequestOrgView({super.key});
  final globalController = Get.find<GlobalController>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RequestList(requests: globalController.requestOrg,)
    );
  }
}