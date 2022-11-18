import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddVuelos extends StatefulWidget {
  const AddVuelos({super.key});

  @override
  State<AddVuelos> createState() => _AddVuelosState();
}

class _AddVuelosState extends State<AddVuelos> {
  final TextEditingController vuelosidController = TextEditingController();
  final TextEditingController destinosidController = TextEditingController();
  final TextEditingController disponibilidadController =
      TextEditingController();
  final TextEditingController tipoVueloController = TextEditingController();
  final TextEditingController avionesidController = TextEditingController();
  final CollectionReference vuelos =
      FirebaseFirestore.instance.collection('vuelos');

  List<String> listaDisponibilidad = <String>[
    'Disponible',
    'No Disponible',
    'Agotado',
    'Cancelado',
  ];
  late String dropdownValueDispo;

  List<String> listatipovuelo = <String>[
    'Comercial',
    'Privado',
    'Cargamento',
  ];
  late String dropdownValuetvuelo;

  @override
  void initState() {
    super.initState();
    vuelosidController.text = "";
    destinosidController.text = "";
    avionesidController.text = "";
    dropdownValuetvuelo = listatipovuelo.first;
    dropdownValueDispo = listaDisponibilidad.first;
    disponibilidadController.text = dropdownValueDispo;
    tipoVueloController.text = dropdownValueDispo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarAddUpdVuelos(),
      body: bodyAddUpdVuelos(),
    );
  }

  bodyAddUpdVuelos() {
    return SingleChildScrollView(
      child: Column(
        children: [
          destinos(),
          aviones(),
          disponibilidad(),
          tipovuelo(),
          btnAdicionar(),
          btnCancelarr()
        ],
      ),
    );
  }

  Widget destinos() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: destinosidController,
        decoration: const InputDecoration(
            labelText: 'Destino',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese destino"),
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget aviones() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: avionesidController,
        decoration: const InputDecoration(
            labelText: 'Avion',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese el avion"),
        style: const TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget disponibilidad() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton<String>(
                  value: dropdownValueDispo,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownColor: const Color.fromARGB(255, 178, 201, 231),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValueDispo = value!;
                      disponibilidadController.text = dropdownValueDispo;
                    });
                  },
                  items: listaDisponibilidad
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tipovuelo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton<String>(
                  value: dropdownValuetvuelo,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownColor: const Color.fromARGB(255, 178, 201, 231),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValuetvuelo = value!;
                      tipoVueloController.text = dropdownValuetvuelo;
                    });
                  },
                  items: listatipovuelo
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
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
          onPressed: () async {
            final String destino = destinosidController.text;
            final String disponibilidad = disponibilidadController.text;
            final String tipovuelo = tipoVueloController.text;
            final String aviones = avionesidController.text;

            await vuelos.add({
              "destino_id": destino,
              "disponibilidad": disponibilidad,
              "tipo_vuelo": tipovuelo,
              "aviones_id": aviones,
            });

            destinosidController.text = "";
            disponibilidadController.text = "";
            tipoVueloController.text = "";
            avionesidController.text = "";
            // ignore: use_build_context_synchronously
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

  appBarAddUpdVuelos() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Agregar Vuelos",
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
