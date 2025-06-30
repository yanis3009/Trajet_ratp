# Application Flutter – Trajet RATP (Offline)

Cette application mobile Flutter permet de calculer un trajet entre deux stations de transport (métro, RER, tram) à Paris, en utilisant des données locales issues de la RATP (sans appel réseau).

## Fonctionnalités

- Saisie du trajet avec autocomplétion pour les stations
- Validation des champs (évite les entrées incorrectes)
- Recherche de trajets directs ou avec correspondance (max 1)
- Affichage clair des lignes empruntées, correspondances et positions recommandées
- Interface fluide et rapide grâce à un traitement 100% local

## Captures d’écran

![Saisie du trajet (sans champs)](assets/screens/champvierge.PNG)
![Saisie de trajet (avec champs auto-complétés)](assets/screens/champsremplis.PNG)
![Résultat de la saisie](assets/screens/résultat.PNG)
![Exemple de message d'erreur](assets/screens/message_derreur.PNG)

## Architecture projet

lib/
├── models/
│   └── trajet.dart
├── pages/
│   ├── saisie_trajet_page.dart
│   └── resultats_page.dart
├── services/
│   ├── data_loader.dart
│   └── recherche_trajets.dart
├── main.dart
assets/
└── ratp_data.json

## Données

Les trajets sont stockés localement dans un fichier JSON :
assets/ratp_data.json

Aucune connexion internet n'est requise.