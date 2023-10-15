import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/modules/petition/controllers/petition_controller.dart';
import 'package:pachitaapp/app/presentation/shared/expanded_button.dart';
import '../../../routes/routes.dart';
import '../../../shared/text_app.dart';
import '../../../theme/colors.dart';

class PetittionForm extends StatelessWidget {
  PetittionForm({super.key});

  final petitionController = Get.find<PetitionController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: petitionController.petitionFormKey,
      child: Column(
        children: [
          TextFormField(
            
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: petitionController.linkFacebookC,
            onSaved: (value){
              petitionController.linkFacebookC.text = value!;
            },
            validator: (value) {
              return petitionController.validateLinkField(value!);
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.dog),
              labelText: 'Facebook',
              hintText: 'Link de facebook',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15,),
          TextFormField(
            
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: petitionController.linkInstagramC,
            validator: (value) {
              return petitionController.validateLinkField(value!);
            },
            onSaved: (value) => petitionController.linkInstagramC.text = value!,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.dog),
              labelText: 'Instagram',
              hintText: 'Link de instagram',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15,),
          TextFormField(
           
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: petitionController.linkWebC,
            validator: (value) {
              return petitionController.validateLinkField(value!);
            },
            onSaved: (value) => petitionController.linkWebC.text = value!,
            decoration: const InputDecoration(
              prefixIcon: Icon(LineIcons.dog),
              labelText: 'Web',
              hintText: 'Link de pagina web',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15,),
          const TextApp(text: "Escribe por que quieres unirte a nuestra app", fontSize: 16, weight: FontWeight.w500, color: Colors.black),
          const SizedBox(height: 15,),
          TextFormField(
             textInputAction: TextInputAction.next,
             autovalidateMode: AutovalidateMode.onUserInteraction,
             controller: petitionController.motivo,
             onSaved: (value) => petitionController.motivo.text = value!,
             onFieldSubmitted: (value){
              
              FocusScope.of(context).nextFocus();
              FocusScope.of(context).unfocus();

            },
            maxLines: 10,
            maxLength: 500,
            decoration: const InputDecoration(
              hintText: 'Ingresa tus comentarios aquí',
              border: OutlineInputBorder(),
            ),
          ),
          ExpandedButton(
            text: const Text('Enviar'),
            color: AppColors.primaryOrange,
            textMode: false,
            action: ()async{

              if(petitionController.validateAccount()){
                // ignore: unrelated_type_equality_checks
                final result = await petitionController.sendRequest();
                if (result) {
                    
                    // ignore: use_build_context_synchronously
                    _mostrarModal(context,0);
                 } else {
                     // ignore: use_build_context_synchronously
                   _mostrarModal(context,1);
                }

              }

  
            },
          )
        ],
      ),
    );
  }
}


class MessageContent extends StatelessWidget {
  const MessageContent({super.key, required this.title , required this.icon, required this.subText, required this.action});

  final String title;
  final String subText;
  final IconData icon;
  final int action;

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisSize: MainAxisSize.max,
      children: [
        TextApp(text: title, fontSize: 20, weight: FontWeight.bold, color: Colors.black,align: TextAlign.center,),
        const SizedBox(height: 20,),
        Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            color: Colors.yellow,
            shape: BoxShape.circle
          ),
          child: Icon(
            icon,
            size: 100,
          ),
        ),
        const SizedBox(height: 20,),
        TextApp(text: subText, fontSize: 18, weight: FontWeight.w500, color: Colors.black, align: TextAlign.center,),
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: const Text("¡Listo!"),
                onPressed: () {
                  if(action == 0){
                    Get.toNamed(Routes.home);
                  }
                  else{
                    Get.back();
                  }
                }
           
              ),
            )
          ],
        )
        
      ],
    );
  }
}

void _mostrarModal(BuildContext context, int status ) {

  showDialog(context: context, builder: (BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      
              status == 0 ? 
              const MessageContent(title: '¡Muchas gracias por tu cooperación! \nTu solicitud ha sido enviada', icon: LineIcons.checkCircleAlt,subText: 'Validaremos tu información, obtendrás respuesta pronto.',action:  0,):
              const MessageContent(title: 'Ya existe una solicitud en proceso', icon: LineIcons.envelope,subText: 'Nuestro equipo esta trabajando\npara válidar tu información.',action: 1,)
             
            ],
          ),
        )
        
      ),
    );
  });
}