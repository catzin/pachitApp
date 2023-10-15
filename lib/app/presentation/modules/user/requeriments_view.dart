import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:pachitaapp/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/requeriments_controller.dart';
import 'package:pachitaapp/app/presentation/modules/user/controllers/user_controller.dart';
import '../../shared/image_grid.dart';
import '../../shared/text_app.dart';
import '../../theme/colors.dart';

class RequerimentsView extends StatelessWidget {
  RequerimentsView({super.key});

  final requerimentController = Get.find<RequerimentsController>();
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: requerimentController.scaffoldKey,
        appBar: AppBar(
          title: const Text("Perfil de adopción"),
          backgroundColor: HexColor(AppColors.primaryOrange),
        ),
        body: Obx(
          () => requerimentController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orangeAccent,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                  homeController.avatar.value,
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
                                      " ${requerimentController.userInfo.value.user.nombre} ${requerimentController.userInfo.value.user.apellidoPaterno} ${requerimentController.userInfo.value.user.apellidoMaterno}",
                                  fontSize: 18,
                                  weight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                TextApp(
                                  text:
                                      " ${requerimentController.userInfo.value.user.ubicacion.street} \n ${requerimentController.userInfo.value.user.ubicacion.sublocality} ${requerimentController.userInfo.value.user.ubicacion.postalCode} \n ${requerimentController.userInfo.value.user.ubicacion.locality} ${requerimentController.userInfo.value.user.ubicacion.administrativeArea}",
                                  fontSize: 15,
                                  weight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ],
                        ),
                  
                        const SizedBox(height: 20,),
                        const TextApp(text: "Acerca de mi", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextApp(text: "Sexo: ${requerimentController.userInfo.value.user.sexoIdSexo.sexo}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                            const SizedBox(height: 5,),
                            TextApp(text: "Fecha de nacimiento: ${DateFormat('dd/MM/yyyy').format(requerimentController.userInfo.value.user.fechaNacimiento)} (${requerimentController.caculateAgeUser(requerimentController.userInfo.value.user.fechaNacimiento)})", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                            const SizedBox(height: 5,),
                            TextApp(text: "Estado civil: ${requerimentController.userInfo.value.user.estadoCivilIdEstadoCivil.estadoCivil}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                            const SizedBox(height: 5,),
                            TextApp(text: "Ocupación: ${requerimentController.userInfo.value.user.ocupacionIdOcupacion.ocupacion}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                            const SizedBox(height: 5,),
                            TextApp(text: "Tipo de domicilio: ${requerimentController.userInfo.value.user.tipodomicilioIdTipoDomicilio.domicilio}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                  
                          ],
                        ),

                        const SizedBox(height: 20,),
                        const TextApp(text: "Redes sociales", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextApp(text: "Facebook: ${requerimentController.userInfo.value.user.linkFacebook}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                            const SizedBox(height: 5,),
                            TextApp(text: "Instagram: ${requerimentController.userInfo.value.user.linkInstagram}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                          ],
                        ),

                        const SizedBox(height: 20,),
                        const TextApp(text: "Contacto", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                        const SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            TextApp(text: "Telefono: ${userController.userData.value.telefono}", fontSize: 15, weight: FontWeight.w500, color: Colors.black),
                          ],
                        ),

                        const SizedBox(height: 20,),
                        const TextApp(text: "Referencias", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                        const SizedBox(height: 20,),
                        Obx(() =>
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              itemCount: requerimentController.userInfo.value.user.contactosReferencia.length,
                              itemBuilder: (context,index){
                          
                                final user =  requerimentController.userInfo.value.user.contactosReferencia[index];
                         
                                return Dismissible(
                                  key: Key(user.idReferencia),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Confirmar borrado'),
                                            content: const Text(
                                                '¿Estás seguro de que deseas borrar este elemento?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text('Borrar'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                   onDismissed: (DismissDirection direction) async{
                                   
                                    final res = await requerimentController
                                        .deleteContact(index);
                                    if (res) {
                                      ScaffoldMessenger.of(requerimentController
                                              .scaffoldKey.currentContext!)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                              child:
                                                  Text('Contacto eliminado')),
                                        ),
                                      );
                                    }

                                    else{

                                      ScaffoldMessenger.of(requerimentController
                                              .scaffoldKey.currentContext!)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                              child:
                                                  Text('Ocurrio un error')),
                                        ),
                                      );

                                    }

                                   },
                                   background:  Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: const Icon(Icons.delete),
                                  ),

                                    child: ListTile(
                                    title: Text(user.nombre),
                                    subtitle: Text(
                                        "${user.apellidoPaterno} ${user.apellidoMaterno}"),
                                    trailing: Text(user.telefono),
                                  ),


                                );
              
                            }
                            ),
                          ),
                        ),


                        const SizedBox(height: 20,),
                        const TextApp(text: "Evidencia de domicilio", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                       SizedBox(
                        height: 200,
                        child: userController.userData.value.domicilio.isEmpty ? const  Center(child: TextApp(text: 'No tienes evidencia registrada', fontSize: 12, weight: FontWeight.w500, color: Colors.blue),) :
                        ImageGrid(imageUrls: userController.userData.value.domicilio.map((domicilio) => domicilio.path).toList()),
                      ),
                      // const TextApp(text: "Mascotas previas", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                      //  SizedBox(
                      //   height: 200,
                      //   child: userController.userData.value.mascotaPrevia.isEmpty ? const  Center(child: TextApp(text: 'No tienes evidencia registrada', fontSize: 12, weight: FontWeight.w500, color: Colors.red),) :
                      //   ImageGrid(imageUrls: userController.userData.value.mascotaPrevia.map<String>((mascota) => mascota.path).toList(),),
                      // ),

                      const TextApp(text: "Documentos", fontSize: 18, weight: FontWeight.w500, color: Colors.black),
                       SizedBox(
                        height: 200,
                        child: userController.userData.value.documentos.isEmpty ? const  Center(child: TextApp(text: 'No tienes evidencia registrada', fontSize: 12, weight: FontWeight.w500, color: Colors.red),) :
                        ImageGrid(imageUrls: userController.userData.value.documentos.map<String>((docs) => docs.path).toList(),),
                      ),

                      const TextApp(text: "Nota\nRecuerda que entre más completo esté tu perfil, tienes una mayor posibilidad de atraer al representante de la organización.", fontSize: 15, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
                      const SizedBox(
                        height: 50,
                      )
                      ],

                  
                    ),
                  ),
                ),
      ),
    );
  }


 

}
