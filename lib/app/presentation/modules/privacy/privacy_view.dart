import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../theme/colors.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text('Aviso de Privacidad'),
      ),
      body: SingleChildScrollView(
        padding:const  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const[
            Text(
              'Aviso de Privacidad',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'En nuestra aplicación de adopción de mascotas, nos comprometemos a proteger la privacidad de los usuarios y a utilizar su información personal de manera responsable y segura.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Información Recopilada',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'En nuestra aplicación, recopilamos la siguiente información personal de los usuarios:',
              style: TextStyle(fontSize: 16.0),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Información de ubicación'),
              subtitle: Text('Accedemos a la ubicación del usuario para proporcionar servicios basados en la ubicación.'),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Fotos de la galería y cámara'),
              subtitle: Text('Los usuarios pueden subir fotos de mascotas desde la galería o tomar fotos con la cámara.'),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Firma digital'),
              subtitle: Text('Los usuarios pueden dibujar su firma digitalmente para verificar la autenticidad y autoría de documentos relacionados con la adopción de mascotas.'),
            ),
            // Agrega más listas para cada tipo de información recopilada

            SizedBox(height: 16.0),
            Text(
              'Uso de la Información',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Utilizamos la información recopilada para los siguientes propósitos:',
              style: TextStyle(fontSize: 16.0),
            ),
            ListTile(
              leading: Icon(Icons.check),
              title: Text('Facilitar la adopción de mascotas'),
              subtitle: Text('Utilizamos la información personal para conectar a los usuarios con organizaciones de mascotas y facilitar el proceso de adopción.'),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Comunicación'),
              subtitle: Text('Utilizamos la información de contacto para mantener una comunicación efectiva con los usuarios, proporcionar actualizaciones sobre el estado de adopción y responder a consultas o solicitudes.'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Mejora de la aplicación'),
              subtitle: Text('Utilizamos datos agregados y anónimos para mejorar y optimizar nuestra aplicación, brindando una experiencia más personalizada y mejorando nuestros servicios.'),
            ),
            // Agrega más listas para cada uso de la información

            SizedBox(height: 16.0),
          ]
        )
        
      )
      
    );
    }

}