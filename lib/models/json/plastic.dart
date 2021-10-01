
class Plastic {

  // PROPERTIES
  final double? pET;
  final double? pVC;
  final double? pC;
  final double? pEHD;

  // CONSTRUCTOR
  Plastic({this.pET, this.pVC, this.pC, this.pEHD});

  // FACTORY CONSTRUCTOR
  factory Plastic.fromJson(Map<String, dynamic> parsedJson) {
    return Plastic(
      pET: parsedJson['PET'],
      pVC: parsedJson['PVC'],
      pC: parsedJson['PC'],
      pEHD: parsedJson['PEHD'],
    );
  }

}