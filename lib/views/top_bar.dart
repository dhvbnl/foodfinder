import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(
        'Seattle Food Guide',
        style: GoogleFonts.robotoSlab()
        ),
    );
  }
}