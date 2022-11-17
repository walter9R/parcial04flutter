import 'package:flutter/material.dart';

class AddCliente extends StatefulWidget {
  const AddCliente({super.key});

  @override
  State<AddCliente> createState() => _AddClienteState();
}

class _AddClienteState extends State<AddCliente> {
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
          NombreCli()
        ],
      ),
    );
  }

  Widget NombreCli() {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: TextField(
        //maxLength: 20,
        decoration: InputDecoration(
            //icon: Icon(Icons.favorite),
            labelText: 'JVM',
            fillColor: Colors.white,
            filled: true,
            //errorText: 'Error message',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.nature_people),
            hintText: "Ingrese su JVM"),
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
      ),
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