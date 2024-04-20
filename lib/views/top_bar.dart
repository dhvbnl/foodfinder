import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light
      ),
      
      title: Text(
        'The Seattle Food Guide',
        style: GoogleFonts.robotoSlab(fontSize: 37, color:  const Color.fromARGB(255, 59, 93, 74))
        ),
    );
  }
}