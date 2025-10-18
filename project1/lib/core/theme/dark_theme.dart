import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xff282828),
    secondary: Color(0xffFFFCFC),
  ),

  scaffoldBackgroundColor: Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
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
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: Color(0xffFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xffFFFCFC),
    ),
    ////////////////افهمها مهم ////////////////////
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),

    ////////////////////////////////////////////////
    labelLarge: TextStyle(
      color: Color(0xC6C6C6),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),

    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
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
      color: Color(0xff6D6D6D),
    ),
    filled: true,
    fillColor: Color(0xff282828),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(width: 0.5, color: Colors.red),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.blue,
    selectionHandleColor: Colors.blue,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xffC6C6C6),
    selectedItemColor: Color(0xff15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff15B86C), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20,fontWeight: FontWeight.w400)
    ),
  ),
);
