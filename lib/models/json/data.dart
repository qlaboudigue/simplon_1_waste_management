import 'package:simplon_waste_management/models/json/district.dart';
import 'package:simplon_waste_management/models/json/json_service.dart';

class Data {

  // PROPERTIES
  final List<District>? districts;
  final List<JsonService>? services;

  // CONSTRUCTOR
  Data({this.districts, this.services});

  // FACTORY CONSTRUCTOR
  factory Data.fromJson(Map<String, dynamic> parsedJson) {

    var districtFromJson = parsedJson['quartiers'] as List;
    List<District> districts = districtFromJson.map((e) => District.fromJson(e))
        .toList();

    var servicesFromJson = parsedJson['services'] as List;
    List<JsonService> services = servicesFromJson.map((e) => JsonService.fromJson(e))
        .toList();

    return Data(
        districts: districts,
        services: services
    );

  }

}