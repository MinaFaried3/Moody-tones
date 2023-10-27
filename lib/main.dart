import 'package:flutter/material.dart';
import 'package:rehab_task/text_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  static const Color blackNavy = Color(0xff0a0c13);
  static const Color darkNavy = Color(0xff0d101c);
  static const Color navy = Color(0xff15192b);
  static const Color lightNavy = Color(0xff252c49);
  static const Color blue = Color(0xff3d5887);
  static const Color lightBlue = Color(0xff909dbd);

  static const Color paleVioletRed = Color(0xffba5874);
  static const Color mauva = Color(0xff645577);
  static const Color thistle = Color(0xffa1859c);
  static const Color lightFuchsia = Color(0xffF5D7DB);
  static const Color beige = Color(0xfffdf4e0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          shadowColor: lightFuchsia,
          primaryColor: beige,
          scaffoldBackgroundColor: darkNavy,
          appBarTheme: const AppBarTheme(
              color: darkNavy,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: beige,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal)),
          cardTheme: const CardTheme(elevation: 8, shadowColor: lightFuchsia),
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 20, color: beige))),
      debugShowCheckedModeBanner: false,
      home: TextScreen(),
    );
  }
}
