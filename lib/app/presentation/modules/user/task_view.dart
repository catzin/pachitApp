import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pachitaapp/app/presentation/theme/colors.dart';
import '../../shared/tittle_section.dart';
import 'widgets/reminder_form.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear"),
        backgroundColor: HexColor(AppColors.primaryOrange),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children:  [
               const TitleSection(
                title: "Recordatorio",
                subTitle: 'Mantente al día',
                icon: LineIcons.archive,
              ),
              const SizedBox(height: 20,),
              ReminderForm()
            ],
          ),
        ),
      ),
    );
    
  }
}

