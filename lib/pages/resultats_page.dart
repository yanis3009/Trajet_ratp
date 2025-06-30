import 'package:flutter/material.dart';
import '../models/trajet.dart';

class ResultatsPage extends StatefulWidget {
  const ResultatsPage({super.key});

  @override
  State<ResultatsPage> createState() => _ResultatsPageState();
}

class _ResultatsPageState extends State<ResultatsPage> {
  late String depart;
  late String arrivee;
  late List<List<Trajet>> resultats;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    depart = args['depart']!;
    arrivee = args['arrivee']!;
    resultats = args['resultats'] as List<List<Trajet>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trajets de $depart à $arrivee')),
      body: resultats.isEmpty
          ? const Center(child: Text('Aucun trajet trouvé.'))
          : ListView.builder(
              itemCount: resultats.length,
              itemBuilder: (context, index) {
                final trajetList = resultats[index];
                final lignes = trajetList.map((t) => t.ligne).join(' → ');
                final positions = trajetList.map((t) => t.position).join(' / ');
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(lignes),
                    subtitle: Text('Position(s) recommandée(s) : $positions'),
                    trailing: Text('${trajetList.length - 1} correspondance(s)'),
                  ),
                );
              },
            ),
    );
  }
}
