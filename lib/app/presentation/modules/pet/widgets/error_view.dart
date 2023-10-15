import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import 'package:pachitaapp/app/presentation/shared/text_app.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';

class ErrorView extends StatelessWidget {

  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
           children: [
             Expanded(
              flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextApp(text: 'Lo sentimos', fontSize: 30, weight: FontWeight.w500, color: Colors.red, align: TextAlign.center,),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('lib/app/presentation/assets/cry.png',width: 200,),
                    const SizedBox(
                      height: 30,
                    ),
                
                    const TextApp(text: 'Los usuarios con una organizacion activa,\nno pueden adoptar.', fontSize: 16, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
                    const SizedBox(
                      height: 30,
                    ),
                    ExpandedButton(text: const Text("Ok, entiendo"), color: AppColors.primaryOrange, textMode: false, action: () => Get.back()),
                  ],
                ),
            )
           ],
          ),
        ),
      ),
    );
  }
}