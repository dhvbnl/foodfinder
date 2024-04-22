import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Creates a platform native App bar 
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  PlatformAppBar build(BuildContext context) {
    return PlatformAppBar(
      title: FittedBox(
        child: Text(
          'The Seattle Food Guide',
          style: GoogleFonts.robotoSlab(
            fontSize: 37,
            color: Theme.of(context).colorScheme.primary
          ),
        ),
      ),
    );
  }
}
