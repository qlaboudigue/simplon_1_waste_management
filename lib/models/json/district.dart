
import 'package:simplon_waste_management/models/json/plastic.dart';

class District {

  // PROPERTIES
  final int? population;
  final Plastic? plastics;
  final double? paper;
  final double? organic;
  final double? glass;
  final double? metal;
  final double? other;

  // CONSTRUCTOR
  District({this.population, this.plastics, this.paper, this.organic, this.glass, this.metal, this.other});

  // FACTORY CONSTRUCTOR
  factory District.fromJson(Map<String, dynamic> parsedJson) {
    return District(
      population: parsedJson['population'],
      plastics: Plastic.fromJson(parsedJson['plastiques']),
      paper: parsedJson['papier'],
      organic: parsedJson['organique'],
      glass: parsedJson['verre'],
      metal: parsedJson['metaux'],
      other: parsedJson['autre'],
    );
  }

}