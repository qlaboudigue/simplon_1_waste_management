import 'package:simplon_waste_management/models/business/business.dart';

class Recyclable extends Waste {

  // PROPERTIES
  int? recycleCo2Rate;

  // CONSTRUCTOR
  Recyclable({required label, required quantity, required burningCo2Rate, required this.recycleCo2Rate}) :
      super(label: label, quantity: quantity, burningCo2Rate: burningCo2Rate);



}