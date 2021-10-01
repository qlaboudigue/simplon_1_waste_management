import 'package:simplon_waste_management/models/json/json.dart';

class Co2 {

  final PlasticGeneratedCo2? plastic;
  final GeneratedCo2? paper;
  final GeneratedCo2? organic;
  final GeneratedCo2? glass;
  final GeneratedCo2? metal;
  final GeneratedCo2? other;

  Co2({this.plastic, this.paper, this.organic, this.glass, this.metal, this.other});

  factory Co2.fromJson(Map<String, dynamic> parsedJson) {
    return Co2(
      plastic: PlasticGeneratedCo2.fromJson(parsedJson['plastiques']),
      paper: GeneratedCo2.fromJson(parsedJson['papier']),
      organic: GeneratedCo2.fromJson(parsedJson['organique']),
      glass: GeneratedCo2.fromJson(parsedJson['verre']),
      metal: GeneratedCo2.fromJson(parsedJson['metaux']),
      other: GeneratedCo2.fromJson(parsedJson['autre']),
    );
  }

}