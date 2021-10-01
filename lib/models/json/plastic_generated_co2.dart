import 'package:simplon_waste_management/models/json/json.dart';

class PlasticGeneratedCo2 {

  final GeneratedCo2? pET;
  final GeneratedCo2? pVC;
  final GeneratedCo2? pC;
  final GeneratedCo2? pEHD;

  PlasticGeneratedCo2({this.pET, this.pVC, this.pC, this.pEHD});

  factory PlasticGeneratedCo2.fromJson(Map<String, dynamic> parsedJson) {
    return PlasticGeneratedCo2(
      pET: GeneratedCo2.fromJson(parsedJson['PET']),
      pVC: GeneratedCo2.fromJson(parsedJson['PVC']),
      pC: GeneratedCo2.fromJson(parsedJson['PC']),
      pEHD: GeneratedCo2.fromJson(parsedJson['PEHD'])
    );
  }



}