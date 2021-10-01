import 'package:simplon_waste_management/models/json/district.dart';
import 'package:simplon_waste_management/models/json/service.dart';

class Data {

  // PROPERTIES
  final List<District>? districts;
  final List<Service>? services;

  // CONSTRUCTOR
  Data({this.districts, this.services});

  // FACTORY CONSTRUCTOR
  factory Data.fromJson(Map<String, dynamic> parsedJson) {

    var districtFromJson = parsedJson['quartiers'] as List;
    List<District> districts = districtFromJson.map((e) => District.fromJson(e))
        .toList();

    var servicesFromJson = parsedJson['services'] as List;
    List<Service> services = servicesFromJson.map((e) => Service.fromJson(e))
        .toList();

    return Data(
        districts: districts,
        services: services
    );

  }

}