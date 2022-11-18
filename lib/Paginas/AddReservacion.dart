import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddReservacion extends StatefulWidget {
  const AddReservacion({super.key});

  @override
  State<AddReservacion> createState() => _AddReservacionState();
}

class _AddReservacionState extends State<AddReservacion> {

  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _vuelosIdController = TextEditingController();
  final CollectionReference _reservaciones = FirebaseFirestore.instance.collection('reservas');

  bool activo = true;

  @override
  void initState() {
    super.initState();
    _estadoController.text = "Activo";
    _vuelosIdController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarAddUpdReser(),
      body: bodyAddUpdReser(),
    );
  }

  bodyAddUpdReser(){
    return SingleChildScrollView(
      child: Column(
        children: [
          switchGenero(),
          vueloId(),
          btnAdicionar(),
          btnCancelarr()
        ],
      ),
    );
  }

  Widget switchGenero() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            activo ? "Activo" : "Inactivo",            
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          Switch(
            value: activo,
            activeColor: Colors.blueAccent,
            onChanged: (value) {
              setState(() {
                activo = value;
                if (activo) {
                  _estadoController.text = "Activo";
                } else {
                  _estadoController.text = "Inactivo";
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget vueloId() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _vuelosIdController,
        decoration: InputDecoration(
            labelText: 'Vuelo',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su Vuelo"),
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget btnAdicionar() {
    return Padding(
      padding: const EdgeInsets.only(left: 100, right: 100, bottom: 25),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 47, 173, 101),
            onPrimary: Colors.white,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed:() async {
            final String estado = _estadoController.text;
            final String vueloId = _vuelosIdController.text;

            await _reservaciones.add(
              {
                "estado" : estado,
                "vuelos_id" : vueloId
              }
            );

            _estadoController.text = "";
            _vuelosIdController.text = "";
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.save,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Confirmar', style: TextStyle(color: Colors.black)),
            ],
          )),
    );
  }

  Widget btnCancelarr() {
    return Padding(
      padding: const EdgeInsets.only(left: 100, right: 100, bottom: 25),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.cancel,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text('Cancelar', style: TextStyle(color: Colors.black)),
            ],
          )),
    );
  }

  appBarAddUpdReser() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Agregar Reserva",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            MaterialButton(
              minWidth: 30.0,
              height: 40.0,
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.blueAccent,
              child: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
          ])),
    );
  }
}