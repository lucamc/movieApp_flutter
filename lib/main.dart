import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/providers/my_https_override.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));

  HttpOverrides.global = MyHttpOverrides();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //En caso que necesitemos mas de un provider.
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home', //Al entrar a la app estamos en el home.
      routes: {
        //Definimos las rutas.+
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen(),
      },
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(color: Colors.orangeAccent.shade700)),
    );
  }
}
