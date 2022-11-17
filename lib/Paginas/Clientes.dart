import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  final CollectionReference _productos = FirebaseFirestore.instance.collection('clientes');

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nombreController.text = documentSnapshot['nombre'].toString();
      //_precioController.text = documentSnapshot['precio'].toString();
    }

  }

    Future<void> _delete(String productId) async {
    await _productos.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El producto fue eliminado correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Mantenimiento Clientes')),
          //shadowColor: Color(Color.fromARGB(a, r, g, b))),
        ),

        body: StreamBuilder(
          stream: _productos.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
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
                      //subtitle: Text(documentSnapshot['precio'].toString()),
                      //: Text(documentSnapshot['precio'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.green,
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                          //aqui van los crud
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
// agregar productos
        //floatingActionButton: FloatingActionButton(
          //onPressed: () => _create(),
          //child: const Icon(Icons.add),
        //),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
