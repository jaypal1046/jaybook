import 'package:flutter/material.dart';
class Ourthem{
  Color _lightgreen=Color.fromARGB(255, 213, 235, 220);
  Color _lightGray=Color.fromARGB(255, 164, 164, 164);
  Color _darkGray=Color.fromARGB(255, 199, 124, 135);
  ThemeData buildTheme(){
    return ThemeData(
      canvasColor: _lightgreen,
      primaryColor: _lightgreen,
      accentColor: _lightGray,
      secondaryHeaderColor: _darkGray,
      hintColor: _lightGray,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: _lightGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: _lightgreen,),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: _darkGray,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          minWidth: 150,
          height: 40.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )
      ),



    );
  }
}