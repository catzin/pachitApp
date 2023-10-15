import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pachitaapp/app/presentation/shared/image_viewer.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imageUrls;
  const ImageGrid({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ImageViewer(path: imageUrls[index]);
              },
            );
          },
          child: SizedBox(
            width: 200,
            height: 200,
            child: CachedNetworkImage(imageUrl: imageUrls[index]),
          ),
        );
        
     // Cargamos la imagen desde la URL
      },
    );
  }
}
