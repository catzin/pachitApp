import 'package:flutter/material.dart';
import '../controllers/new_controller.dart';

class CustomPicker extends StatelessWidget {
  const CustomPicker({
    super.key,
    required this.newViewController,
  });

  final NewViewController newViewController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
  crossAxisCount: 3,
  childAspectRatio: 3 / 2,
  children: [
    // Contenedor grande de la izquierda
    Container(
      color: Colors.red,
      height: double.infinity, // Cubre todo el alto
    ),
    // Contenedor superior derecho
    Container(
      color: Colors.green,
    ),
    // Contenedor inferior derecho
    Container(
      color: Colors.blue,
    ),
  ],
    
  );
    
  }
}
