import 'package:simplon_waste_management/index.dart';
import 'package:simplon_waste_management/models/business/burner.dart';
import 'package:simplon_waste_management/models/interface/burner_interface.dart';
import 'package:simplon_waste_management/models/json/json.dart';

class Waste {

  // PROPERTIES
  String? label;
  double? quantity;
  int? burningCo2Rate;
  Service? service;

  // CONSTRUCTOR
  Waste({required this.label, required this.quantity, required this.burningCo2Rate});

  // METHOD
  void setService(Service newService) {
    service = newService;
  }



}