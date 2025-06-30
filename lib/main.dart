import 'package:flutter/material.dart';
import 'pages/saisie_trajet_page.dart';
import 'pages/resultats_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trajet RATP',
      initialRoute: '/',
      routes: {
        '/': (context) => const SaisieTrajetPage(),
        '/resultats': (context) => const ResultatsPage(),
      },
    );
  }
}
