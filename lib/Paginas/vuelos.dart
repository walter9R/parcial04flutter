import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parcial04flutter/Paginas/addVuelos.dart';
import 'package:parcial04flutter/Paginas/updVuelos.dart';

class Vuelos extends StatefulWidget {
  const Vuelos({super.key});

  @override
  State<Vuelos> createState() => _VuelosState();
}

class _VuelosState extends State<Vuelos> {
// text fields' controllers
  final TextEditingController vuelosidController = TextEditingController();
  final TextEditingController destinosidController = TextEditingController();
  final TextEditingController disponibilidadController =
      TextEditingController();
  final TextEditingController tipoVueloController = TextEditingController();
  final TextEditingController avionesidController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  final CollectionReference _vuelos =
      FirebaseFirestore.instance.collection('vuelos');

  final aviones = FirebaseFirestore.instance.collection('aviones');
  final destinos = FirebaseFirestore.instance.collection('destinos');

  Future<void> delete(String vuelosId) async {
    await _vuelos.doc(vuelosId).delete();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El vuelo: $vuelosId ,Ha Sido Eliminado')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarVuelos(),
      body: body(),
    );
  }

  appBarVuelos() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(159, 132, 181, 219),
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Mantenimiento Vuelos",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              minWidth: 30.0,
              height: 40.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddVuelos()));
              },
              color: Colors.blueAccent,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ])),
    );
  }

  body() {
    return StreamBuilder(
      stream: _vuelos.snapshots(),
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
                  title: Text("Vuelo: ${documentSnapshot.id}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getMarcar(documentSnapshot['aviones_id']),
                      getDestinos(documentSnapshot['destinos_id']),
                      Text(
                          "Disponibilidad: ${documentSnapshot['disponibilidad']}"),
                      Text("Tipo de Vuelo: ${documentSnapshot['tipo_vuelo']}"),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () async {
                              if (await confirm(context,
                                  title: const Text("Confirmar"),
                                  content: const Text(
                                      "Esta Seguro De Actualizar El Registro"))) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => UpdVuelos(
                                              vuelos_upd: documentSnapshot,
                                            )));
                                //=> _update(documentSnapshot)
                              }
                            }),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              if (await confirm(context,
                                  title: const Text("Confirmar"),
                                  content: const Text(
                                      "Esta Seguro De Eliminar El Registro"))) {
                                delete(documentSnapshot.id);
                              }
                            }),
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
    );
  }

  Widget getMarcar(String id) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: aviones.doc(id).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          var value = output!['marca']; // <-- Your value
          return Text("Avion: $value");
        }

        return const Text("Acion: ");
      },
    );
  }

  Widget getDestinos(String id) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: destinos.doc(id).snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          var value = output!['nombre']; // <-- Your value
          return Text("Destino: $value");
        }

        return const Text("Destino: ");
      },
    );
  }
}
