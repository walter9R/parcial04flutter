import 'package:flutter/material.dart';
import 'package:parcial04flutter/Paginas/Clientes.dart';
import 'package:parcial04flutter/Paginas/Vuelos.dart';

class Contenedor extends StatefulWidget {
  const Contenedor({super.key});

  @override
  State<Contenedor> createState() => _ContenedorState();
}

class _ContenedorState extends State<Contenedor> {
  int menuactivo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
      bottomNavigationBar: footer(),
    );
  }

  Widget footer() {
    List items = [
      Icons.account_box,
      Icons.calendar_month_sharp,
      Icons.airplanemode_active,
    ];

    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 100, right: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(3, (index) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    menuactivo = index;
                  });
                },
                icon: Icon(
                  items[index],
                  color: menuactivo == index ? Colors.amber : Colors.grey,
                ));
          }),
        ),
      ),
    );
  }

  Widget body() {
    return IndexedStack(index: menuactivo, children: const [
      Clientes(),
      Clientes(),
      Vuelos(),
    ]);
  }
}
