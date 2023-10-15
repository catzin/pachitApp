import 'package:flutter/material.dart';
import 'package:pachitaapp/app/presentation/shared/brand_bar.dart';
import 'package:pachitaapp/app/presentation/shared/heading.dart';
import 'widgets/about_form.dart';


class AboutView extends StatelessWidget {
   const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          child: Column(
            children: [
              const BrandBar(),
              const Expanded(
                flex: 1,
                  child: Heading(
                principalText: '¡Comencemos!',
                secondaryText: 'Cuentanos de ti',
              )
                ),
              Expanded(
                flex: 3,
                child: AboutForm()
              ),
           
            ],
          )
      ),
    )
    

    );
  }
}









