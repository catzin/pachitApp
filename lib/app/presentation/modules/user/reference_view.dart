import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../../shared/tittle_section.dart';
import '../../theme/colors.dart';
import 'widgets/reference_form.dart';

class ReferenceView extends StatelessWidget {
  const ReferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Referencia"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              TitleSection(
                title: "Crear nueva",
                subTitle: 'Referencia',
                icon: LineIcons.peopleCarry,
              ),
              SizedBox(height: 25,),
              ReferenceForm()
            ],

          ),
        ),
      ),
    );
  }
}