import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/presentation/modules/login/controllers/login_controller.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';


class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final loginControlller = Get.find<LoginController>();

  InputDecoration setInputStyles(String hint, Icon icon) {
    return InputDecoration(
      filled: true,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: icon,
      ),
      border: InputBorder.none,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      fillColor: Colors.lightBlue.withOpacity(0.06),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginControlller.loginFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: setInputStyles(
                'correo', const Icon(Icons.verified_user_rounded)),
            keyboardType: TextInputType.emailAddress,
            controller: loginControlller.emailController,
            onSaved: (value) {
              loginControlller.email = value!;
            },
            validator: (value) {
              return loginControlller.validateEmail(value!);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: setInputStyles(
                'contraseña', const Icon(Icons.verified_user_rounded)),
            keyboardType: TextInputType.text,
            controller: loginControlller.passwordController,
            obscureText: true,
            onSaved: (value) {
              loginControlller.password = value!;
            },
            validator: (value) {
              return loginControlller.validatePassword(value!);
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              TextButton(
                onPressed:() {
                  
                },
                child: const Text("Olvidé mi contraseña"))
            ],
          ),
          Obx(() => loginControlller.isSending.value == false ? 

            ExpandedButton(
                text: const Text("Ingresar"),
                color: AppColors.primaryOrange,
                textMode: false,
                action: () {
                  final valid = loginControlller.checkLogin();
                  if (valid) {
                    _submitForm(loginControlller.emailInput, loginControlller.passInput);
                  }
                }) : const Center(child: CircularProgressIndicator(),)
          ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text("O continua con", style: TextStyle(color: Colors.grey[700])),

                   Expanded(
                     child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[600],
                                     ),
                   ),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  GestureDetector(
                    onTap: ()async{

                      await loginControlller.loginWithGoogle();
                      //final valid = await loginControlller.loginWithGoogle();
          //             if(valid){
          //               Get.toNamed(Routes.register);
          //             }
          //             else{
          //                 Get.snackbar('Error', 'No se puedo acceder',
          //                 icon: const Icon(Icons.error),
          //                 backgroundColor: Colors.amberAccent,
          //                 duration: const Duration(seconds: 2),
          // );

          //             }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200]
                        ),
                      child: Image.asset(
                        'lib/app/presentation/assets/google.png',
                        height: 40,
                      ),
                    ),
                  ),
                  
                ],
              )

        ],
      ),
    );
  }

  void _submitForm(String email, String password) async{
  loginControlller.login(email, password);
 
  }
  
}
