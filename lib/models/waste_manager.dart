import 'package:simplon_waste_management/services/services.dart';

class WasteManager {

  // PROPERTIES
  final DataService dataService;
  final Co2Service co2service;
  Map<String, double>? wasteQuantityList = {};
  Map<String, double>? recyclerList = {};
  double? incineratorCapacity;
  double? composterCapacity;

  // CONSTRUCTOR
  WasteManager({required this.dataService, required this.co2service, this.wasteQuantityList, this.recyclerList, this.incineratorCapacity, this.composterCapacity});

  // METHODS

}