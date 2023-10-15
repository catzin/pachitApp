import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_binding.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class PachitApp extends StatelessWidget {
  const PachitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash, 
        getPages: pages,
        initialBinding: MainBinding(),
        theme: ThemeData(
            
             tabBarTheme: const TabBarTheme(
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 3,
                ),
              ),
              
   
              // Establece el color de fondo aquí
  
            ),
  ),
        
       
      )

    );
  }
}