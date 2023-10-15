import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';

import '../theme/colors.dart';

class PetCard extends StatelessWidget {
  final String image;
  final String petName;
  final String petSex;
  final int petType;
  final bool ? showStatus;

  const PetCard({
    super.key,
    required this.image,
    required this.petName,
    required this.petSex,
    required this.petType,
    this.showStatus
  });


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2/2,
      child: Container(
         margin: const EdgeInsets.only(right: 10),
         decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                   image: CachedNetworkImageProvider(image), fit: BoxFit.cover)
                  ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    stops: const [0.1, 0.9],
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.1)
                    ]
                    )
            ),
            
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showStatus == true? 
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: HexColor("4CB749")
                        ),
                      ),
                    ) : Container()
                    ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Text(
                          petName,
                          style: GoogleFonts.acme(
                              color: HexColor(
                                AppColors.primaryOrange,
                              ),
                              textStyle: const TextStyle(fontSize: 25)
                              ),
                        ),
                         
                        Container(
            
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // ignore: unrelated_type_equality_checks
                            color: petSex.toLowerCase().compareTo("macho") == 0 ?  HexColor(AppColors.blueLight) : Colors.pinkAccent
                          ),
      
                          // ignore: unrelated_type_equality_checks
                          child: petType == 1 ?  const Icon(LineIcons.dog) : const Icon(LineIcons.cat) ,
                        )
      
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      )
    );
  }
}