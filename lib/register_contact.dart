import 'package:crud_register/my_home_page.dart';
import 'package:crud_register/text_box.dart';
import 'package:flutter/material.dart';

class RegisterContact extends StatefulWidget{
  const RegisterContact({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterContact();

}

class _RegisterContact extends State<RegisterContact>{
  late TextEditingController controllerName;
  late TextEditingController controllerSurname;
  late TextEditingController controllerPhone;

  @override
  void initState(){
    controllerName = TextEditingController();
    controllerSurname = TextEditingController();
    controllerPhone = TextEditingController();
    super.initState();
  }

  


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Register Contactos"),
      ),
    body: ListView(
      
     children: [
      TextBox(controllerName, "Nombre"),
       TextBox(controllerSurname, "Apellido"),
        TextBox(controllerPhone, "Telefono"),
        ElevatedButton(onPressed:() {
          String name = controllerName.text;
          String surname = controllerSurname.text;
          String phone = controllerPhone.text;

          if (name.isNotEmpty && surname.isNotEmpty && phone.isNotEmpty) {
            Navigator.pop(context,
             Client(name: name, surname: surname, phone: phone) 
             );
          }
        },
         child: const Text("Guardar contacto")),
     ],
    ));
  }
  
  

}