import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../routes/routes.dart';
import '../../shared/expanded_button.dart';
import '../../shared/image_grid.dart';
import '../../shared/image_viewer.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';
import 'controllers/candidate_controller.dart';

class CandidateView extends StatelessWidget {
  CandidateView({Key? key}) : super(key: key);
  final candidateController = Get.find<CandidateController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.blueAccent),
        title: const Text('Candidato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final foto = candidateController.argsRequest!.usuario.fotoPerfil.contains("https") ? candidateController.argsRequest!.usuario.fotoPerfil : "https://pachstorage.s3.amazonaws.com/avatar_profile.png";
                          return ImageViewer(path: foto);
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                        candidateController.argsRequest!.usuario.fotoPerfil.contains("https") ?  candidateController.argsRequest!.usuario.fotoPerfil : "https://pachstorage.s3.amazonaws.com/avatar_profile.png" ,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextApp(
                        text:
                            " ${candidateController.argsRequest!.usuario.nombre} ${candidateController.argsRequest!.usuario.apellidoPaterno} ${candidateController.argsRequest!.usuario.apellidoMaterno}",
                        fontSize: 18,
                        weight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      TextApp(
                        text:
                            " ${candidateController.argsRequest!.usuario.ubicacion.street} \n ${candidateController.argsRequest!.usuario.ubicacion.sublocality} ${candidateController.argsRequest!.usuario.ubicacion.postalCode} \n ${candidateController.argsRequest!.usuario.ubicacion.locality} ${candidateController.argsRequest!.usuario.ubicacion.administrativeArea}",
                        fontSize: 15,
                        weight: FontWeight.bold,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                  text: "Acerca de mi",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                      text:
                          "Sexo: ${candidateController.argsRequest!.usuario.sexoIdSexo.sexo}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  TextApp(
                      text:
                          "Fecha de nacimiento: ${DateFormat('dd/MM/yyyy').format(candidateController.argsRequest!.usuario.fechaNacimiento)}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  TextApp(
                      text:
                          "Estado civil: ${candidateController.argsRequest!.usuario.estadoCivilIdEstadoCivil.estadoCivil}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  TextApp(
                      text:
                          "Ocupación: ${candidateController.argsRequest!.usuario.ocupacionIdOcupacion.ocupacion}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  TextApp(
                      text:
                          "Tipo de domicilio: ${candidateController.argsRequest!.usuario.tipodomicilioIdTipoDomicilio.domicilio}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                  text: "Redes sociales",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                      text:
                          "Facebook: ${candidateController.argsRequest!.usuario.linkFacebook}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                  const SizedBox(
                    height: 5,
                  ),
                  TextApp(
                      text:
                          "Instagram: ${candidateController.argsRequest!.usuario.linkInstagram}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                  text: "Contacto",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                      text:
                          "Telefono: ${candidateController.argsRequest!.usuario.telefono}",
                      fontSize: 15,
                      weight: FontWeight.w500,
                      color: Colors.black),
                ],
              ),
              TextApp(text: 'Horario de contacto\n${candidateController.argsRequest!.usuario.horariocontacto.especificacion}', fontSize: 15, weight: FontWeight.w500, color: Colors.black),
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                  text: "Referencias",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: candidateController.argsRequest!.usuario.contactosReferencia.length,
                      itemBuilder: (context, index) {
                        final user = candidateController.argsRequest!.usuario.contactosReferencia[index];

                        return ListTile(
                            title: Text(user.nombre),
                            subtitle: Text(
                                "${user.apellidoPaterno} ${user.apellidoMaterno}"),
                            trailing: Text(user.telefono),
                          );
                      }),
                ),
              
              const SizedBox(
                height: 20,
              ),
              const TextApp(
                  text: "Evidencia de domicilio",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 200,
                child: candidateController.argsRequest!.usuario.domicilio.isEmpty
                    ? const Center(
                        child: TextApp(
                            text: 'No se proporcionó evidencia',
                            fontSize: 12,
                            weight: FontWeight.w500,
                            color: Colors.blue),
                      )
                    : ImageGrid(
                        imageUrls: candidateController.argsRequest!.usuario.domicilio
                            .map((domicilio) => domicilio.path)
                            .toList()),
              ),
              const TextApp(
                  text: "Mascotas previas",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 200,
                child: candidateController.argsRequest!.usuario.mascotaPrevia.isEmpty
                    ? const Center(
                        child: TextApp(
                            text: 'No se proporcionó evidencia',
                            fontSize: 12,
                            weight: FontWeight.w500,
                            color: Colors.red),
                      )
                    : ImageGrid(
                        imageUrls: candidateController.argsRequest!.usuario.mascotaPrevia
                            .map<String>((mascota) => mascota.path)
                            .toList(),
                      ),
              ),
              const TextApp(
                  text: "Documentos",
                  fontSize: 18,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 200,
                child:  candidateController.argsRequest!.usuario.documentos.isEmpty
                    ? const Center(
                        child: TextApp(
                            text: 'No se proporcionó evidencia',
                            fontSize: 12,
                            weight: FontWeight.w500,
                            color: Colors.red),
                      )
                    : ImageGrid(
                        imageUrls: candidateController.argsRequest!.usuario.documentos
                            .map<String>((docs) => docs.path)
                            .toList(),
                      ),
              ),
             
            
              Column(
                children: [
                  ExpandedButton(
                    text: const Text("Agendar entrevista"),
                    color: AppColors.primaryOrange,
                    textMode: false,
                    action: () {

                    },
                  ),

                  ExpandedButton(
                    text: const Text("Generar contrato"),
                    color: AppColors.blueAccent,
                    textMode: false,
                    action: ()async{

                      final res = await candidateController.generateContrate();
                      

                      if(res){

                         Get.dialog(
                                
                                AlertDialog(
                                  
                                  title: const Text('Listo!',textAlign: TextAlign.center,),
                                  content: FractionallySizedBox(
                                    
                                    widthFactor: 0.8,
                                    heightFactor: 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:   [
                                          TextApp(
                                          text:
                                              "Enviamos un contrato de adopción a ${candidateController.argsRequest!.usuario.nombre} ${candidateController.argsRequest!.usuario.apellidoPaterno}",
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                          align: TextAlign.center,
                                        ),
                                        const Icon(
                                          LineIcons.handshakeAlt,
                                          size: 60,
                                          color: Colors.blue
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:  HexColor(AppColors.primaryOrange),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                   
                                          // Cierra el modal
                                      },
                                      child: const Text('¡Listo!'),
                                    ),
                                  ],
                                ),
                      
                                barrierDismissible: false
                      
                              );

                      }

                    },
                  ),
                 const SizedBox(height: 20,),
                 const TextApp(text: 'Modificar estatus de la solicitud', fontSize: 15, weight: FontWeight.w500, color: Colors.black,align: TextAlign.start,),
                 DropdownButton<String>(
                    // value: _opcionSeleccionada,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.red,
                    ),
                    onChanged: (String? newValue)async{
            
                      if(newValue == "2"){
                        final change = await candidateController.changeRequestStatus(candidateController.argsRequest!.idSolicitudAdopcion,2);

                        if(change){
                          Get.dialog(
                           AlertDialog(
                            title: Row(
                              children: const[
                                Text("Solicitud rechazada"),
                                Icon(LineIcons.xbox)
                              ],
                            ),
                            content: const Text("Se le notificará al usuario"),
                          )
                        );

                        }
                        
                      }
                      else{
                        final change = await candidateController.changeRequestStatus(candidateController.argsRequest!.idSolicitudAdopcion,3);
                        if(change){
                          Get.toNamed(Routes.endView , arguments:{ 'args':candidateController.argsRequest, 'idmascota':candidateController.idMascota});
                        }

                        
                      }
                    },
                    items: <Map<String,dynamic>>[{'text' : 'Rechazar', 'id':2 }, {'text' : 'Finalizar adopción', 'id':3}]
                        .map<DropdownMenuItem<String>>((Map<String,dynamic> value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['text']),
                      );
                    }).toList(),
                  )
                ],
              ),
                const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          makePhoneCall('+52${candidateController.argsRequest!.usuario.telefono}');
     
        },
        child: const Icon(LineIcons.phone),
      ),
    );
  }
}

void makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunch(phoneUri.toString())) {
    await launch(phoneUri.toString());
  } else {
    throw 'No se pudo realizar la llamada';
  }
}
