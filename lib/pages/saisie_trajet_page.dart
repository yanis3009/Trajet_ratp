import 'package:flutter/material.dart';
import '../services/data_loader.dart';
import '../services/recherche_trajets.dart';
import '../models/trajet.dart';

class SaisieTrajetPage extends StatefulWidget {
  const SaisieTrajetPage({super.key});

  @override
  State<SaisieTrajetPage> createState() => _SaisieTrajetPageState();
}

class _SaisieTrajetPageState extends State<SaisieTrajetPage> {
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _arriveeController = TextEditingController();

  List<String> _stations = [];
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _departController.addListener(_onFieldChanged);
    _arriveeController.addListener(_onFieldChanged);
    _chargerStations();
  }

  void _onFieldChanged() {
    setState(() {}); // Rebuild à chaque saisie
  }

  Future<void> _chargerStations() async {
    final trajets = await DataLoader.chargerTrajets();
    final setStations = <String>{};

    for (final trajet in trajets) {
      setStations.add(trajet.depart);
      setStations.add(trajet.arrivee);
    }

    setState(() {
      _stations = setStations.toList()..sort();
      _ready = true;
    });
  }

  bool get champsValides {
    final depart = _departController.text.trim().toLowerCase();
    final arrivee = _arriveeController.text.trim().toLowerCase();
    final stationsNorm = _stations.map((s) => s.toLowerCase()).toList();

    return stationsNorm.contains(depart) &&
        stationsNorm.contains(arrivee) &&
        depart != arrivee;
  }

  void _rechercher() async {
    final depart = _departController.text.trim();
    final arrivee = _arriveeController.text.trim();

    final trajets = await DataLoader.chargerTrajets();
    final resultats = RechercheTrajets.rechercher(
      tousLesTrajets: trajets,
      depart: depart,
      arrivee: arrivee,
    );

    if (resultats.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Aucun trajet trouvé"),
          content: const Text("Aucun trajet ne correspond à votre recherche."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/resultats',
      arguments: {
        'depart': depart,
        'arrivee': arrivee,
        'resultats': resultats,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Saisie du trajet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                return _stations.where((station) =>
                    station.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                controller.addListener(() {
                  _departController.text = controller.text;
                });
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(labelText: 'Station de départ'),
                );
              },
              onSelected: (selection) => _departController.text = selection,
            ),
            const SizedBox(height: 16),
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                return _stations.where((station) =>
                    station.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                controller.addListener(() {
                  _arriveeController.text = controller.text;
                });
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(labelText: 'Station d’arrivée'),
                );
              },
              onSelected: (selection) => _arriveeController.text = selection,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: champsValides ? _rechercher : null,
              child: const Text("Rechercher"),
            ),
          ],
        ),
      ),
    );
  }
}
