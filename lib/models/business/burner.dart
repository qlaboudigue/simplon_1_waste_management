import 'package:simplon_waste_management/models/interface/burner_interface.dart';

class Burner {

  int? burnerCapacity = 0;

  Burner({required this.burnerCapacity});

  int? burnWaste(int wasteQuantity, int burningCo2Rate) {
    burnerCapacity = burnerCapacity! - wasteQuantity;
    return wasteQuantity * burningCo2Rate;
  }

}


/*
class Burner implements BurnerInterface {

  int? lineQuantity;
  int? lineCapacity;

  Burner({required this.lineQuantity, required this.lineCapacity});

  // METHODS
  int? calculateCapacity() {
    return lineCapacity! * lineQuantity!;
  }

  @override
  int? burn(int co2Rate) {
    return calculateCapacity()! * co2Rate;
  }



}

 */