import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0xff161F1B),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    centerTitle: false,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF15B86C)),
      foregroundColor: WidgetStatePropertyAll(Color(0xffFFFCFC)),
      // fixedSize: Size(MediaQuery.of(context).size.width, 40),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((State) {
      if (State.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((State) {
      if (State.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((State) {
      if (State.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
    }),
  ),

  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xff161F1B),
    ),
    ////////////////افهمها مهم ////////////////////
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),

    ////////////////////////////////////////////////
    labelLarge: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    ////for donetasks/////
    titleLarge: TextStyle(
      fontSize: 16,
      color: Color(0xff6A6A6A),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff282828),
      overflow: TextOverflow.ellipsis,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xff3A4640),
    ),
    filled: true,
    fillColor: Color(0xffFFFFFF),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 0.5, color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 1, color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 1, color: Color(0xffD1DAD6)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 1, color: Color(0xffD1DAD6)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xff3A4640),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color:Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xffD1DAD6), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    // shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400,
      color: Color(0xff161F1B)
      ),
    ),
  ),
);
