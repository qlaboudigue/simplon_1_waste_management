import 'package:simplon_waste_management/models/business/business.dart';

class Organic extends Waste {

  // PROPERTIES
  int? compostCo2Rate;

  // CONSTRUCTOR
  Organic({required label, required quantity, required burningCo2Rate, required this.compostCo2Rate}) :
        super(label: label, quantity: quantity, burningCo2Rate: burningCo2Rate);

  // METHODS


}