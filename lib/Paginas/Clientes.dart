import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:parcial04flutter/Paginas/AddCliente.dart';
import 'package:parcial04flutter/Paginas/UpdCliente.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  // text fields' controllers
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechnacimientoController = TextEditingController();
  final TextEditingController _reservacionController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final CollectionReference _clientes = FirebaseFirestore.instance.collection('clientes');

  @override
  void initState() {
    super.initState();
  }

  //actualizacion de clientes
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      //_nombreController.text = documentSnapshot['nombre'].toString();
      //_precioController.text = documentSnapshot['precio'].toString();
    }
  }

  Future<void> _delete(String clienteId, String nameClient) async {
    await _clientes.doc(clienteId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('El Cliente ' + nameClient +' Ha Sido Eliminado')
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra de titulo
      appBar: AppBar(
        title: const Center(child: Text('Mantenimiento Clientes')),
      ),

      //listado de clientes extraidos de base de datos
      body: StreamBuilder(
        stream: _clientes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),                  
                  child: ListTile(
                    title: Text("Cliente" + "\n" ),
                    subtitle: Text(
                      "Nombre: " + documentSnapshot['nombre'].toString() + "\n" + 
                      "Apellido: " + documentSnapshot['apellido'].toString() + "\n" +
                      "Fecha Nacimiento: " + documentSnapshot['fechnacimiento'].toString() + "\n" +
                      "Sexo: " + documentSnapshot['sexo'].toString() + "\n" +
                      "Tipo: " + documentSnapshot['tipo'].toString() + "\n" +
                      "Usuario: " + documentSnapshot['usuario'].toString(),
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed:() async {
                              if (await confirm(
                                context,
                                title: const Text("Confirmar"),
                                content: const Text("Esta Seguro De Actualizar El Registro")
                              )) {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UdpCliente(cliente_upd: documentSnapshot,)));
                                //=> _update(documentSnapshot)
                              }
                            }
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed:() async {
                              if (await confirm(
                                context,
                                title: const Text("Confirmar"),
                                content: const Text("Esta Seguro De Eliminar El Registro")
                              )) {
                                _delete(documentSnapshot.id, documentSnapshot['nombre'].toString());
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          //no se obtuvo una respuesta de datos
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // adicion de clientes
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCliente()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
