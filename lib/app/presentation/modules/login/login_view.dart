import 'package:flutter/material.dart';
import '../../shared/brand_bar.dart';
import 'widgets/login_form.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                      children: [
                        const BrandBar(), 
                        const Ilustration(),
                         LoginForm()
                         ],
                    ),
            )),
      ),
    );
  }
}

class Ilustration extends StatelessWidget {
  const Ilustration({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Column(

      children: [
        Image.asset(
          'lib/app/presentation/assets/nigga.png',
          height: height * 0.3,
          width: width * 0.5,
        ),
        
        const Text("Hola de nuevo",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(
          height: 6,
        ),
       
      ],
    );
  }
}
