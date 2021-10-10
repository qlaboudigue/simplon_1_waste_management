
class Composter {

  // PROPERTIES
  final int? itemQuantity;
  final int? itemCapacity;

  // CONSTRUCTOR
  Composter(this.itemQuantity, this.itemCapacity);

  // METHODS
  int calculateComposterCapacity() {
    /// Return the composter overall capacity based on composter properties
    return itemQuantity! * itemCapacity!;
  }


}