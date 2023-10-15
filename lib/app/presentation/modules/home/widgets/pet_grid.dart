import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Pet {
  final String name;
  final String image;
  final String info;

  Pet({required this.name, required this.image, required this.info});
}

class PetGrid extends StatelessWidget {
  // Esta es tu lista de mascotas. Puedes llenarla con los datos que quieras.
  final List<Pet> pets = [
    Pet(name: 'Dog', image: 'https://pachstorage.s3.amazonaws.com/16852165958391685216593202.jpg', info: 'Dog is friendly'),
    Pet(name: 'Dog', image: 'https://pachstorage.s3.amazonaws.com/16852165958391685216593202.jpg', info: 'Cat is independent'),
    // Añade más mascotas aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pets.length,
      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Ajusta la cantidad de elementos por fila aquí
      ),
      itemBuilder: (BuildContext context, int index) {
        return FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(pets[index].image,),
                fit: BoxFit.cover,
              ),
            ),
          ),
          back: Container(
            color: Colors.white,
            child: Center(
              child: Text(pets[index].info),
            ),
          ),
        );
      },
    );
  }
}
