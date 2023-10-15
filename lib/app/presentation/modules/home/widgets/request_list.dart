import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../domain/models/adoption_org.dart';
import '../../../routes/routes.dart';


class RequestList extends StatelessWidget {
  const RequestList({super.key, required this.requests});
  final List<PetOrgRequest> requests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Solicitudes Recientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Expanded(
          child: ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return ListTile(
                onTap: (){
                  Get.toNamed(Routes.petRequestList , arguments: request.mascotaId);
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(request.mascotaImgsPath),
                  radius: 25,
                ),
                title: Text(request.mascotaNombre),
                trailing: const Icon(LineIcons.arrowCircleRight)
              );
            },
          ),
        ),
      ],
    );
  }
}
