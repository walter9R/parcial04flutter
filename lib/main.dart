import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parcial04flutter/contenedor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FirebaseParcial04());
}

class FirebaseParcial04 extends StatelessWidget {
  const FirebaseParcial04({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: Contenedor(),
    );
  }
}
