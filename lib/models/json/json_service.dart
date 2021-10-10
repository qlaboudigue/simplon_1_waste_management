

class JsonService {

  // PROPERTIES
  final String? type;
  final int? furnaceLines;
  final int? lineCapacity;
  final int? capacity;
  final List<dynamic>? acceptedPlastics;
  final int? foyer;

  // CONSTRUCTOR
  JsonService({this.type, this.furnaceLines, this.lineCapacity, this.capacity, this.acceptedPlastics, this.foyer});

  // FACTORY
  factory JsonService.fromJson(Map<String, dynamic> parsedJson) {
    return JsonService(
      type: parsedJson['type'],
      furnaceLines: parsedJson['ligneFour'],
      lineCapacity: parsedJson['capaciteLigne'],
      capacity: parsedJson['capacite'],
      acceptedPlastics: parsedJson['plastiques'],
      foyer: parsedJson['foyers'],
    );
  }

}