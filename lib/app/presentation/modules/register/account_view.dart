import 'package:flutter/material.dart';
import '../../shared/brand_bar.dart';
import '../../shared/heading.dart';
import 'widgets/account_form.dart';


class AccountView extends StatelessWidget {
  const AccountView({super.key});



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: [
            const BrandBar(),
            const Expanded(
              flex: 1,
              child: Heading(
                  principalText: '¡Ya casi!',
                  secondaryText: 'Crea tu cuenta'),
            ),
            Expanded(
              flex: 2,
              child: Image.asset(
                'lib/app/presentation/assets/nigga.png',
                height: height * 0.3,
                width: width * 0.5,
              ),
            ),
            Expanded(
              flex: 2,
              child: AccountForm(),
            )
          ]),
        ),
      ),
    );
  }
}
