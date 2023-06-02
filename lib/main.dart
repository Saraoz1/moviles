import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
 MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

//Se cumple con el crud = 6
//Puntualidad de entrega = 6
//Avances = 6
//Arquitectura limpia = 3
//Libreria estado de conectividad de red = 12
// Libreria de persistencia de datos = 12