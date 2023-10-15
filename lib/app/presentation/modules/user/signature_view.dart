
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../theme/colors.dart';
import 'widgets/signature.dart';

class SignatureView extends StatelessWidget {
  const SignatureView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(AppColors.primaryOrange),
        title: const Text("Agregar firma"),
      ),
      body: const SignatureWidget(),
    );
  }
}