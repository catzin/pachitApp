// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.image
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover
        ),
        shape: BoxShape.circle,
        boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.6),
          spreadRadius: 2,
          blurRadius: 2,
          offset: const Offset(0, 2), // Cambia la dirección de la sombra
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 40,
            child: Container(
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(LineIcons.star,color: Colors.white,size: 15),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
