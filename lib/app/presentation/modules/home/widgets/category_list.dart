import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/category_controller.dart';
import 'package:pachitaapp/app/presentation/routes/routes.dart';
import '../../../theme/colors.dart';
import '../controllers/home_controller.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.homeController,
    required this.categoryController
  });

  final HomeController homeController;
  final CategoryController categoryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Categorias",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() =>
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [

              InkWell(
                onTap: (){
                  categoryController.selectedDogs.value = !categoryController.selectedDogs.value;
                  categoryController.selectedCats.value = false;
                  if(categoryController.selectedDogs.value){
                    Get.toNamed(Routes.petsList, arguments: "1");

                  }
       

                } ,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:categoryController.selectedDogs.value ? HexColor(AppColors.primaryOrange) : HexColor(AppColors.secondaryLight),
                  ),
                  height: 80,
                  width: 80,
                  child: const Icon(LineIcons.dog,size: 30),
                  
                ),
              ),
              const SizedBox(width: 10),

              InkWell(
                onTap: (){
                  categoryController.selectedCats.value = !categoryController.selectedCats.value;
                  categoryController.selectedDogs.value = false;
                  if(categoryController.selectedCats.value){
                    Get.toNamed(Routes.petsList , arguments: "2");

                  }
                   

                } ,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:categoryController.selectedCats.value ? HexColor(AppColors.primaryOrange) : HexColor(AppColors.secondaryLight),
                  ),
                  child:const Icon(LineIcons.cat,size: 30,),

                ),
              )
            
      
            ],
          ),
        ),
      ],
    );
  }
}

