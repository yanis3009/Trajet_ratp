import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/trajet.dart';

class DataLoader {
  static Future<List<Trajet>> chargerTrajets() async {
    final String jsonString = await rootBundle.loadString('assets/ratp_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Trajet.fromJson(e)).toList();
  }
}
