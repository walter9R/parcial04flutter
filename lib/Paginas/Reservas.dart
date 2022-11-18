import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:parcial04flutter/Paginas/AddCliente.dart';
import 'package:parcial04flutter/Paginas/AddReservacion.dart';
import 'package:parcial04flutter/Paginas/UpdCliente.dart';
import 'package:parcial04flutter/Paginas/UpdReserva.dart';

class Reservas extends StatefulWidget {
  const Reservas({super.key});

  @override
  State<Reservas> createState() => _ReservasState();
}

class _ReservasState extends State<Reservas> {
  
  final CollectionReference _reservas = FirebaseFirestore.instance.collection('reservas');
  final TextEditingController _reservacinController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> _delete(String reservaId) async {
    await _reservas.doc(reservaId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('La Reservacion Ha Sido Eliminada')
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: appBarReservas(),      
      //listado de clientes extraidos de base de datos
      body: StreamBuilder(
        stream: _reservas.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData)  {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),                  
                  child: ListTile(
                    title: Text("Reservacion" + "\n" ),
                    subtitle: Text(
                      "Estado: " + documentSnapshot['estado'].toString() + "\n" +
                      "Vuelo: " + documentSnapshot['vuelos_id'.toString()] 
                      ,
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
                                    builder: (_) => UdpReserva(reserva_upd: documentSnapshot,)));
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
                                _delete(documentSnapshot.id);
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
    );
  }

  appBarReservas() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(159, 132, 181, 219),
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Mantenimiento Reservas",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              minWidth: 30.0,
              height: 40.0,
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddReservacion()));
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
}