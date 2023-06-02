import 'package:connectivity/connectivity.dart';
import 'package:crud_register/crud_conectivy.dart';
import 'package:crud_register/db_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;
  

  //Get All data from databse

  void _refreshData() async {
    final data = await SQLHelper.getData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }
  @override
  void initState(){
    super.initState();
    _refreshData();
  }

//Add data
Future<void> _addData() async{
  await SQLHelper.createData(_titleController.text, _descController.text);
  _refreshData();
}
//update data
Future<void> _updateData(int id) async{
  await SQLHelper.updateData(id, _titleController.text, _descController.text);
   _refreshData();
}
//delete data
void _deleteData(int id) async{
  await SQLHelper.deleteData(id);
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    backgroundColor: Colors.redAccent,
    content: Text("Producto eliminado")));
    _refreshData();
}

final TextEditingController _titleController = TextEditingController();
final TextEditingController _descController = TextEditingController();

void showBottomSheet(int? id) async{
  //si la identificación no está, entonces se actualizará de otra manera si hay nuevos datos
  // cuando se procesa el ícono de edición, se le dará una identificación a la función  y
  // se editará
  if(id!=null){
    final existingData = _allData.firstWhere((element) => element['id']==id);
    _titleController.text = existingData['title'];
    _descController.text = existingData['desc'];

  }
  showModalBottomSheet(
    elevation: 5,
    isScrollControlled: true,
    context: context,
   builder: (_) => Container(
    padding: EdgeInsets.only(
      top: 30,
      left: 15,
      right: 15,
      bottom: MediaQuery.of(context).viewInsets.bottom + 50,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Titulo",
          ),
        ),
        const SizedBox(height: 10,),
        TextField(
          controller: _descController,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Descripcion",
          ),
        ),
        const SizedBox(height: 20,),

        Center(
          child: ElevatedButton(
            onPressed: () async {
              if (id == null) {
                await _addData();
              }

               if (id != null){
              await _updateData(id);  
             }
              
             _titleController.text = "";
             _descController.text = "";

               // ignore: use_build_context_synchronously
               Navigator.of(context).pop();
               print("Agregar datos");
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(id == null ? "Agregar producto" : "Actualizar",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                
              ),
              ),
               ),
          ) 
        )
      ],
    ),
   ));
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: const Text(" Registro de Productos", style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black

      ),),
      backgroundColor: const Color.fromARGB(184, 36, 48, 214),
      ),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(
          backgroundColor: Color.fromARGB(255, 90, 7, 255), strokeWidth: 10,),
          ): ListView.builder(
        itemCount: _allData.length,
        itemBuilder: (context, index) => Card(
           margin: const EdgeInsets.all(15),
           child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                _allData[index]['title'],
                style: const TextStyle(
                  fontSize: 20,
                ), 
              ),
              ),
                subtitle: Text(_allData[index]['desc']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){
                      showBottomSheet(_allData [index] ["id"]);
                    }, icon: const Icon(
                      Icons.edit,
                      color: Colors.indigo,
                      )
                      ),
                      IconButton(onPressed: (){
                        _deleteData(_allData[index]['id']);
                      }, icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      )
                      )
                  ],),
           ),
        ),
        ),
        floatingActionButton: Container(
           padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () => showBottomSheet(null),
                child:  const Icon(Icons.add,
                ), 
              ),
              
               ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAppCrud()));
                    },
                    child: const Text('Ver estado de la conexion' ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ),
       
    );

  
  }
}

mixin _connectionStatus {
}