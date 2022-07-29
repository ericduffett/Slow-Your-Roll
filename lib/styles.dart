import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class DarkBackgroundContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const DarkBackgroundContainer({Key? key, required this.child, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            transform: GradientRotation(-math.pi / 4),
            colors: [
              Color(0xFF2c3e50), //Deep Blue
              //Color(0xFF2d3436), //Deeper Blue
              Color(0xFF12100e), //Not quite black
              //Color(0xFF000000) //Black
            ],
          )
      ),
      child: child,
    );
  }
}

// class LightBackgroundContainer extends StatelessWidget {
//   final Widget child;
//   const LightBackgroundContainer({Key? key, required this.child}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomCenter,
//             transform: GradientRotation(-math.pi / 4),
//             colors: [
//               //Color(0xFFb8c6db), //Light blue
//               //Color(0xFFe9e9e9), //Gray
//               Color(0xFFffffff), //White
//               Color(0xFFf1f2f6), //Almost white
//               //Color(0xFFf5f7fa), //Almost white
//
//               //Color(0xFFd7e1ec), //Blue-Gray
//             ],
//           )
//       ),
//       child: child,
//     );
//   }
// }

final lightTextThemeData = ThemeData(
  appBarTheme: const AppBarTheme(
    color:  Colors.transparent,
    elevation: 0,
  ),
  dialogTheme: DialogTheme(
    titleTextStyle: TextStyle(
        color:  const Color(0xFF2c3e50),
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
    ),
    contentTextStyle:  TextStyle(
      color:  const Color(0xFF2c3e50),
      fontSize: 16.0,
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.black54,
    selectedItemColor: Colors.black,
    selectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: const Color(0xFF2c3e50),
      textStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: GoogleFonts.redHatDisplay().fontFamily,
      )
    ),
  ),
  hintColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.grey,
      fontFamily: GoogleFonts.redHatDisplay().fontFamily,
    ),
    contentPadding: const EdgeInsets.all(16.0),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        )
    ),
    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        )
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        )
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: const BorderSide(color: Colors.white),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
          textStyle: GoogleFonts.redHatDisplay()
      )
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        textStyle: GoogleFonts.redHatDisplay()
      )
  ),
  textTheme: GoogleFonts.redHatDisplayTextTheme(
      const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        headline4: TextStyle(
          color: Color(0xFF2c3e50),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontStyle: FontStyle.italic
        ),
        headline6: TextStyle(
            color: Color(0xFF2c3e50),
            fontSize: 16,
            fontStyle: FontStyle.italic
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      )
  ),
);



