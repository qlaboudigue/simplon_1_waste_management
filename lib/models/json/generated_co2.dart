
class GeneratedCo2 {

  final int? burnedGeneratedCo2;
  final int? recycledGeneratedCo2;
  final int? compostedGeneratedCo2;


  GeneratedCo2({this.burnedGeneratedCo2, this.recycledGeneratedCo2, this.compostedGeneratedCo2});

  factory GeneratedCo2.fromJson(Map<String, dynamic> parsedJson) {
    return GeneratedCo2(
      burnedGeneratedCo2: parsedJson['incineration'],
      recycledGeneratedCo2: parsedJson['recyclage'],
      compostedGeneratedCo2: parsedJson['compostage']
    );


  }

}