import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/user_controller.dart';
import 'widgets/edit_form.dart';

class EditView extends StatelessWidget {
  EditView({super.key});
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: Obx(()=> Text(userController.userName)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextApp(
                        text: 'Editar mi información',
                        fontSize: 20,
                        weight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      const TextApp(
                        text: 'Mantén tu información actualizada',
                        fontSize: 15,
                        weight: FontWeight.bold,
                        color: Colors.grey,
                      ),

                      const SizedBox(height: 10,),

                      Obx(() => 
                        TextApp(
                          text: 'Registrado en : ${DateFormat('dd/MM/yyyy').format(userController.userRegisterDate)}',
                          fontSize: 15,
                          weight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 10,),

                      Obx(() => 
                        TextApp(
                          text: 'Correo : ${userController.userEmail}',
                          fontSize: 15,
                          weight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),

                      Obx(() => 
                        TextApp(
                          text: 'Edad : ${userController.caculateAgeUser()}',
                          fontSize: 15,
                          weight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 75,
                    height: 75,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amberAccent),
                    child: const Center(
                      child: Icon(
                        LineIcons.addressBook,
                        size: 35,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25,),
              EditForm(userController: userController)
            ],
          ),
        ),
      ),
    );
  }
}