
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/domain/enums/index.dart';
import '../../../shared/expanded_button.dart';
import '../../../shared/text_input.dart';
import '../../../theme/colors.dart';
import '../controller/register_controller.dart';

class AccountForm extends StatelessWidget {
  AccountForm({super.key});
  final regController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
        key: regController.accountFormKey,
        
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: setInputStyles('correo', const Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
              controller: regController.correo,
              validator: (value) {
                return regController.validateField(value!,TypeInput.email);

              },
              onSaved: (value) {
                regController.email.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: setInputStyles('teléfono', const Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
              controller: regController.telefono,
              validator: (value) {
                return regController.validateField(value!,TypeInput.phone);

              },
              onSaved: (value) {
                regController.phone.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: setInputStyles('contraseña', const Icon(Icons.password)),
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: regController.contrasena,
              validator: (value){
                return regController.validateField(value!, TypeInput.passwordConfirm);
              },
              onSaved: (value) {
                regController.password.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: setInputStyles('confirma contraseña', const Icon(Icons.password)),
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: regController.confirm,
              onSaved: (value) {
                regController.confirmpass.value = value!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => regController.sending.value == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  :
               ExpandedButton(
                text: const Text("Crear"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: () async{
                  final res =  regController.validateAccount();
               
                  if(res){
                    regController.createAccount();
                  }
                  else{
            
                     Get.snackbar(
                      'Error',
                      'Verifica tus datos',
                      icon: const Icon(Icons.error),
                      backgroundColor: Colors.amberAccent,
                      duration: const Duration(seconds: 2),
                    );
            
                  }
                
            
            
                },
              ),
            )
          ],
        ),
      
      ),
      
    );
  }
}