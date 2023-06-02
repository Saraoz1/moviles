import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:crud_register/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() {
  runApp(const MyAppCrud());
}

class MyAppCrud extends StatelessWidget {
  const MyAppCrud({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomeCrud(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomeCrud extends StatefulWidget {
  const MyHomeCrud({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomeCrud> createState() => _MyHomeCrudState();
}

class _MyHomeCrudState extends State<MyHomeCrud> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
       print(e.toString());
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 215, 214, 214),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            TextButton(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 0, 0)),
  ),
  onPressed: () { 
   Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  
  },
  
  child: const Icon(Icons.arrow_back,
  size:30 ,
  )
),
         const Center(
            child: Text('Connectivity Plus' ,style: TextStyle(
             color: Colors.blueGrey,
           fontWeight: FontWeight.w900,
         ),),
          ),        
          ],
        ),
      
        elevation: 4,
      ),
      body: Center(
          child: Text('Estado de la conexion: ${_connectionStatus.toString()}', 
          style: const TextStyle(color: Colors.black,
          fontWeight: FontWeight.w800,
          fontSize: 15,
          ),
          ) 
                
          ),
          
       
    );
  }
}