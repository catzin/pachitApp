import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import '../../../routes/routes.dart';
import '../../../theme/colors.dart';

class FavoritePet extends StatelessWidget {
  const FavoritePet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/app/presentation/assets/catback.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
            'Mascota con mas likes',
            style: GoogleFonts.ibmPlexSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
            ),
          ),
        ),
        Positioned(
          bottom: 10, // Aquí se ajusta la posición del botón
          right: 10,
          child:  ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.petOfWeek);
              
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: HexColor(AppColors.primaryOrange), elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Row(
              children: [
                Text('Ver ahora',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Icon(LineIcons.arrowCircleRight)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
