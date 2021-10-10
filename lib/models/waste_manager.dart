import 'package:simplon_waste_management/models/business/business.dart';
import 'package:simplon_waste_management/models/business/recyclable.dart';
import 'package:simplon_waste_management/services/services.dart';
import 'package:simplon_waste_management/constants.dart';

class WasteManager {

  // PROPERTIES
  final DataService dataService;
  final Co2Service co2service;
  List<Waste> wastes = [];
  Map<String, double> results = Map<String, double>();
  double burnerCo2 = 0.0;
  double globalCo2 = 0.0;

  // CONSTRUCTOR
  WasteManager({required this.dataService, required this.co2service});

  // METHODS
  void buildWastesList() async {

    /// Get data from data.json and co2.json
    final data = await dataService.loadData();
    final co2 = await co2service.loadCo2();

    /// Init waste and service map with key:value pairs
    Map<String, double> wasteQuantities = _initializeMap(kWasteKeys);
    Map<String, double> servicesList = _initializeMap(kServiceKeys);

    /// Stock wastes in a map
    for (var district in data.districts!) {
      wasteQuantities.update(kPaperKey, (value) => value + district.paper!);
      wasteQuantities.update(kOrganicKey, (value) => value + district.organic!);
      wasteQuantities.update(kGlassKey, (value) => value + district.glass!);
      wasteQuantities.update(kMetalKey, (value) => value + district.metal!);
      wasteQuantities.update(kOtherKey, (value) => value + district.other!);
    }

    /// Stock services capacities in a map
    for (var service in data.services!) {
      switch (service.type) {
        case kBurnerKey: {
          Burner burner = Burner(burnerCapacity: service.furnaceLines! * service.lineCapacity!);
          // Burner burner = Burner(lineQuantity: service.furnaceLines, lineCapacity: service.lineCapacity);
          // var burnerCapacity = burner.calculateCapacity();
          servicesList.update(
              kBurnerKey, (value) => value + burner.burnerCapacity!);
          break;
        }
        case kPlasticRecyclerKey: {
          servicesList.update(
              kPlasticRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kPaperRecyclerKey: {
          servicesList.update(
              kPaperRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kGlassRecyclerKey: {
          servicesList.update(
              kGlassRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kMetalRecyclerKey: {
          servicesList.update(
              kMetalRecyclerKey, (value) => value + service.capacity!);
          break;
        }
        case kComposterKey: {
          Composter composter = Composter(service.capacity, service.foyer);
          servicesList.update(
              kComposterKey, (value) => value + composter.calculateComposterCapacity());
          break;
        }

      }
    }

    print('Incinérateur: ${servicesList[kBurnerKey]}');
    print('Plastique: ${servicesList[kPlasticRecyclerKey]}');
    print('Paper: ${servicesList[kPaperRecyclerKey]}');
    print('Verre: ${servicesList[kGlassRecyclerKey]}');
    print('Metal: ${servicesList[kMetalRecyclerKey]}');
    print('Composteur: ${servicesList[kComposterKey]}');

    /*
    /// Create waste object based on map results
    Recyclable paper = Recyclable(
        label: kPaperKey,
        quantity: wasteQuantities[kPaperKey],
        burnGeneratedCo2: co2.paper!.burnedGeneratedCo2,
        recycledGeneratedCo2: co2.paper!.recycledGeneratedCo2
    );
    Organic organic = Organic(
        quantity: wasteQuantities[kOrganicKey],
        burnGeneratedCo2: co2.organic!.burnedGeneratedCo2,
        compostGeneratedCo2: co2.organic!.compostedGeneratedCo2
    );
    Recyclable glass = Recyclable(
        label: kGlassKey,
        quantity: wasteQuantities[kGlassKey],
        burnGeneratedCo2: co2.glass!.burnedGeneratedCo2,
        recycledGeneratedCo2: co2.glass!.recycledGeneratedCo2
    );
    Recyclable metal = Recyclable(
        label: kMetalKey,
        quantity: wasteQuantities[kMetalKey],
        burnGeneratedCo2: co2.metal!.burnedGeneratedCo2,
        recycledGeneratedCo2: co2.metal!.recycledGeneratedCo2
    );
    Waste other = Waste(
        label: kOtherKey,
        quantity: wasteQuantities[kOtherKey],
        burnGeneratedCo2: co2.other!.burnedGeneratedCo2,
    );

     */

    /*
    wastes.add(paper);
    wastes.add(organic);
    wastes.add(glass);
    wastes.add(metal);
    wastes.add(other);

     */

    /// Manage waste
    for (var waste in wastes) {

      print('${waste.label} : ${waste.quantity}');
      // var co2 = waste.burner!.burn(waste.burnGeneratedCo2!);
      print(co2);
      // globalCo2 = globalCo2 + co2!;
    }
    print('Global: $globalCo2');

    /// Pour chaque déchet, Si le recycleur existe on recycle la quantité
    /// correspondant à la capacité max du recycleur, on récupère la différence
    /// et on la brule.
    /// Il faut donc instancier les déchets avec leur recycleur.

  }

  /// Initialize map with key:value pairs based on list
  Map<String, double> _initializeMap(List<String> list) {
    Map<String, double> map = Map<String, double>();
    for (var element in list) {
      map[element] = 0;
    }
    return map;
  }

}