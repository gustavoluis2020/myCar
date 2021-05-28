import 'package:flutter/material.dart';
import 'package:my_car/contants.dart';
import 'package:my_car/date_piker/date_piker_km.dart';
import 'package:my_car/screens/alcool_ou_gasolina.dart';
import 'package:my_car/screens/intro_slider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_car/screens/media_gas_alc.dart';
import 'package:my_car/screens/notas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Color(0xFF388e3c)),
        primarySwatch: appColor,
        primaryColor: Colors.green[700],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', "BR"),
      ],
      initialRoute: "/",
      routes: {
        "/gasoual": (context) => GasOuAl(),
        "/mediaGasAlc": (context) => MediaGasAlc(),
        "/meuKm": (context) => DatePikerKM(),
        "/notas": (context) => Notas(),
      },
      debugShowCheckedModeBanner: false,
      home: IntroSliderPage(),
    );
  }
}
