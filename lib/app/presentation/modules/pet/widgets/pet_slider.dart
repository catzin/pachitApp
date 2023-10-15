import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pet_profileController.dart';

class PetSlider extends StatelessWidget {
  PetSlider({
    super.key,
  });
  final petProfileController = Get.find<PetProfileController>();

  @override
  Widget build(BuildContext context) {
    return Center(
  
      child: Obx(() =>
      petProfileController.isLoading.value ? const Center(child: CircularProgressIndicator(),):
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            //aspectRatio: 15/6,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            //onPageChanged: (){},
            scrollDirection: Axis.horizontal,
          ),
           items: petProfileController.images.map((pet) {
            return Image.network(pet.path);
          }).toList(),
        ),
      ),
    );
  }
}
