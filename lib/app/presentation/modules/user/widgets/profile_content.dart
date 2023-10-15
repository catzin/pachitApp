import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import '../../../shared/text_app.dart';
import '../controllers/shelter_controller.dart';
import 'number_data.dart';
import 'profile_picture.dart';


class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.shelterController
  });

  final ShelterController shelterController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: SizedBox(
          width: double.infinity,      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePicture(image: shelterController.data.fotoPerfil),
                  const SizedBox(width: 20,),
                   const Expanded(  
                    child: NumberData(),
                  )
                ],
              ),
              const SizedBox(height: 25,),
              TextApp(
                text: shelterController.data.nombre, 
                fontSize: 20,
                weight: FontWeight.bold,
                color: Colors.black, 
              ),

              TextApp(
                text: shelterController.data.descripcion, 
                fontSize: 16,
                weight: FontWeight.bold,
                color: Colors.grey, 
              ),
              const SizedBox(height: 30,),
              const TextApp(
                text: 'Siguenos en redes', 
                fontSize: 20,
                weight: FontWeight.bold,
                color: Colors.black, 
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()async{
                       
                      },
                      child: InkWell(
                        onDoubleTap:()async => await  _launchUrl(shelterController.data.linkFacebook),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: const Icon(
                            LineIcons.facebookF,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                   
                      InkWell(
                        onDoubleTap: ()async => await  _launchUrl(shelterController.data.linkInstagram),
                        child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor("#3f729b"),
                        ),
                        child: const Icon(LineIcons.instagram,size: 40,color: Colors.white,),
                                          ),
                      ),
                  
                    InkWell(
                      onDoubleTap: ()async => await  _launchUrl(shelterController.data.linkWeb),
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(LineIcons.link,size: 40,color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const TextApp(
                text: 'Apoyanos en el siguiente link', 
                fontSize: 20,
                weight: FontWeight.bold,
                color: Colors.black, 
              ),
               const SizedBox(height: 20,),
              InkWell(
                onDoubleTap: () async =>
                    await _launchUrl(shelterController.data.linkDonacion),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    LineIcons.donate,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
  }
}