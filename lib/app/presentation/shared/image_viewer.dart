import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';



class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key, required this.path,

  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: MediaQuery.of(context)
                .size
                .width *
            0.8,
        height: MediaQuery.of(context)
                .size
                .height *
            0.8,
        child: Column(
          children: [
            Expanded(
              child: 
                
               PhotoView(
                  imageProvider:
                      CachedNetworkImageProvider(path),
                ),
              
            ),
            const SizedBox(height: 16.0),
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
