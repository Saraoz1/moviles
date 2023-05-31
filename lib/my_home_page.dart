import 'dart:html';

import 'package:crud_register/message_response.dart';
import 'package:crud_register/modify_contact.dart';
import 'package:crud_register/register_contact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final String _title;
  MyHomePage(this._title);
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  List<Client> clients = [
     Client(name: 'Lauro', surname: 'Saraoz', phone: '9614530515'), 
  ];




  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
    body: ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index){
        return ListTile(
          onTap: () {
            Navigator.push(
              context, MaterialPageRoute(
                //modificar contacto
                builder: (_)=> ModifyContact(clients[index])))
                .then((newContact) {
                  if (newContact != null){
                    setState(() {
                      clients.removeAt(index);

                      clients.insert(index, newContact);
                      messageResponse(context, newContact.name+" a sido modificado");
                    });
                  }
                });
          },
          onLongPress: () {
               removeClient(context, clients[index]);
          },

          title: Text(clients[index].name + " " + clients[index].surname),
          subtitle: Text(clients[index].phone),
          leading: CircleAvatar(
            child: Text(clients[index].name.substring(0,1)),
          ),
          trailing: const Icon(Icons.call,
          color: Colors.red,),
        );
      },
      //registar
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(
              context, MaterialPageRoute(builder: (_) => const RegisterContact()))
          .then((newContact) {
            if(newContact != null){
               setState(() {
                 clients.add(newContact);
                 messageResponse(
                  context, newContact.name + "se a guardado ");
               });
            }
          });

      },
      tooltip: "Agregar contacto",
      child: const Icon(Icons.add),
      ),
    );
  }
  //eliminar
  removeClient(BuildContext context, Client client) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
             title: const Text("Eliminar cliente"),
             content: const Text("Esta seguro de eliminar a "),
             actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    clients.remove(client);
                    Navigator.pop(context);
                  });
              },
              child: const Text("Eliminar", style: TextStyle(
                color: Colors.red
              ),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar", style: TextStyle(color: Colors.blue),)
              )
             ],
          ));
  
  }

}


class Client {
  var name;
  var surname;
  var phone;
  
  Client({this.name, this.surname, this.phone});

}