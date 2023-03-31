import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

categoryBox(
    {required double height, required double width, required String image}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: height * 0.11,
        width: width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(0.33),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/$image.png",
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        alignment: Alignment.center,
      ),
      const SizedBox(height: 8),
      Text(
        image.toUpperCase(),
        style: GoogleFonts.ubuntu(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.8),
          letterSpacing: 2,
        ),
      ),
    ],
  );
}
