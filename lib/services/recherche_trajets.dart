import '../models/trajet.dart';

class RechercheTrajets {
  static List<List<Trajet>> rechercher({
    required List<Trajet> tousLesTrajets,
    required String depart,
    required String arrivee,
  }) {
    List<List<Trajet>> resultats = [];

    // 🔹 1. Trajets directs
    for (var trajet in tousLesTrajets) {
      if (trajet.depart == depart && trajet.arrivee == arrivee) {
        resultats.add([trajet]);
      }
    }

    // 🔸 2. Trajets avec une correspondance
    for (var trajet1 in tousLesTrajets) {
      if (trajet1.depart == depart) {
        for (var trajet2 in tousLesTrajets) {
          if (trajet1.arrivee == trajet2.depart &&
              trajet2.arrivee == arrivee &&
              trajet1.ligne != trajet2.ligne) {
            resultats.add([trajet1, trajet2]);
          }
        }
      }
    }

    // 🔺 Tri par nombre de correspondances (puis par ligne alpha si égalité)
    resultats.sort((a, b) {
      int diff = a.length.compareTo(b.length);
      if (diff != 0) return diff;
      return a.first.ligne.compareTo(b.first.ligne);
    });

    // 🔽 Limite à 5 résultats max
    return resultats.take(5).toList();
  }
}
