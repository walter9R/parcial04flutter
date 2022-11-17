import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddCliente extends StatefulWidget {
  const AddCliente({super.key});

  @override
  State<AddCliente> createState() => _AddClienteState();
}

class _AddClienteState extends State<AddCliente> {

  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechnacimientoController = TextEditingController();
  final TextEditingController _reservacionController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final CollectionReference _clientes = FirebaseFirestore.instance.collection('clientes');

  bool activo = true;
  List<String> lstTipoClie = <String>[
    'Elite',
    'Ejecutivo',
  ];
  late String dropdownValueTipoCli;

  @override
  void initState() {
    super.initState();
    _cedulaController.text = "";
    _nombreController.text = "";
    _apellidoController.text = "";
    _fechnacimientoController.text = "";
    _reservacionController.text="W6mHr47WuKPpt4BuPNEr";//cambiar la forma de conseguir el dato
    _sexoController.text= "Masculino";
    _usuarioController.text = "";
    dropdownValueTipoCli = lstTipoClie.first;
    _tipoController.text = dropdownValueTipoCli;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarAddUpdCliente(),
      body: bodyAddUpdCliente(),
    );
  }

  bodyAddUpdCliente(){
    return SingleChildScrollView(
      child: Column(
        children: [
          CedulaCli(),
          NombreCli(),
          ApellidoCli(),
          FechaCli(),
          switchGenero(),
          tipoCliente(),
          UsuarioCliente(),
          btnAdicionar(),
          btnCancelarr()
        ],
      ),
    );
  }

  Widget NombreCli() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _nombreController,
        decoration: InputDecoration(
            labelText: 'Nombre',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su Nombre"),
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget ApellidoCli() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _apellidoController,
        decoration: InputDecoration(
            labelText: 'Apellido',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su Apellido"),
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget CedulaCli() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _cedulaController,
        decoration: InputDecoration(
            labelText: 'Cedula',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su Cedula"),
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  Widget FechaCli() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _fechnacimientoController,
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Fecha Nacimiento (Año - Mes - Dia)" 
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100)
          );

          if (pickedDate != null) {
            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              _fechnacimientoController.text = formattedDate; //set output date to TextField value.
            });
          } else {

          }
        },
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
            activo ? "Masculino" : "Femenino",            
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          Switch(
            value: activo,
            activeColor: Colors.blueAccent,
            onChanged: (value) {
              setState(() {
                activo = value;
                if (activo) {
                  _sexoController.text = "Masculino";
                } else {
                  _sexoController.text = "Femenino";
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget tipoCliente() {
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
                  value: dropdownValueTipoCli,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownColor: Color.fromARGB(255, 178, 201, 231),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValueTipoCli = value!;
                      _tipoController.text = dropdownValueTipoCli;
                    });
                  },
                  items: lstTipoClie
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

  Widget UsuarioCliente() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        controller: _usuarioController,
        decoration: InputDecoration(
            labelText: 'Usuario',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            //prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su Usuario"),
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
            final String cedula = _cedulaController.text;
            final String nombre = _nombreController.text;
            final String apellido = _apellidoController.text;
            final String fechnacimiento = _fechnacimientoController.text;
            final String reservacion = _reservacionController.text;
            final String sexo = _sexoController.text;
            final String tipo = _tipoController.text;
            final String usuario = _usuarioController.text;

            await _clientes.add(
              {
                "cedula" : cedula,
                "nombre" : nombre,
                "apellido" : apellido,
                "fechnacimiento" : fechnacimiento, 
                "sexo" : sexo,
                "tipo" : tipo,
                "usuario" : usuario,
                "reservas_id": reservacion
              }
            );

            _cedulaController.text = "";
            _nombreController.text = "";
            _apellidoController.text = "";
            _fechnacimientoController.text = "";
            _reservacionController.text="";
            _sexoController.text= "";
            _tipoController.text = "";
            _usuarioController.text = "";
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

  appBarAddUpdCliente() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Agregar Cliente",
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