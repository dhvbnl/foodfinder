import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  PlatformAppBar build(BuildContext context) {
    return PlatformAppBar(
      /*systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light
      ),*/
      
      title: FittedBox(
        child: Text(
          'The Seattle Food Guide',
          style: GoogleFonts.robotoSlab(fontSize: 37, color:  const Color.fromARGB(255, 59, 93, 74))
          ),
      ),
    );
  }
}