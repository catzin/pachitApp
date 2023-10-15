import 'package:flutter/material.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import 'package:get/get.dart';
import '../../shared/index.dart';


class StartedView extends StatelessWidget {
  const StartedView({super.key});
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SafeArea(
          child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceEvenly,
            children:[
              const Heading(
                principalText: '¡Haz un nuevo amigo!',
                secondaryText: '¡Adopta, no compres!',
              ),
              Column(
                children:  [
                   
                   Column(
                    children:[

                      Image.asset(
                      'lib/app/presentation/assets/man.png',
                        height: height * 0.6,
                        width: width * 0.6,
                        fit: BoxFit.cover,
      
                      ),
         
                      ExpandedButton(
                        text:  const Text("Iniciar Sesión"),
                        textMode: false,
                        color: AppColors.primaryOrange,
                        action: () => Get.toNamed(Routes.login) ,
                      ),
                      ExpandedButton(
                        text:  const Text("Registrarme"), 
                        textMode: true,
                        color: AppColors.primaryOrange,
                         action: () => Get.toNamed(Routes.register) ,
                        )
                    ],
                   )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}



