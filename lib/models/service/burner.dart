
class Burner {

  // PROPERTIES
  final int? lineQuantity;
  final double? lineCapacity;

  // CONSTRUCTOR
  Burner(this.lineQuantity, this.lineCapacity);

  // METHODS
  double calculateBurnerCapacity(){
    /// Return the burner waste capacity based on the burner properties
    return lineQuantity! * lineCapacity!;
  }

}