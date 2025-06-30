class Trajet {
  final String ligne;
  final String depart;
  final String arrivee;
  final String position;

  Trajet({
    required this.ligne,
    required this.depart,
    required this.arrivee,
    required this.position,
  });

  factory Trajet.fromJson(Map<String, dynamic> json) {
    return Trajet(
      ligne: json['ligne'],
      depart: json['depart'],
      arrivee: json['arrivee'],
      position: json['position_average'],
    );
  }
}
