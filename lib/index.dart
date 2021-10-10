import 'package:simplon_waste_management/models/business/business.dart';
import 'package:simplon_waste_management/services/co2_service.dart';
import 'package:simplon_waste_management/services/data_service.dart';
import 'constants.dart';
import 'models/business/waste.dart';

class Index {

  void buildResults() async {
    /// Get data from data.json and co2.json
    final DataService dataService = DataService();
    final Co2Service co2service = Co2Service();
    final data = await dataService.loadData();
    final co2 = await co2service.loadCo2();

    /// Instance manager
    Manager manager = Manager();

    /// Init waste and service map with key:value pairs
    Map<String, double> wasteList = _initializeMap(kWasteKeys);
    Map<String, double> servicesList = _initializeMap(kServiceKeys);

    /// Add services to Manager
    for (var service in data.services!) {
      switch (service.type) {
        case kBurnerKey: {
          servicesList.update(
              kBurnerKey, (value) => value + service.furnaceLines! * service.lineCapacity!);
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
          servicesList.update(
              kComposterKey, (value) => value + service.foyer! * service.capacity!);
          break;
        }
      }
    }


    Incinerateur incinerateur = Incinerateur(kOtherKey, servicesList[kBurnerKey]);
    manager.addService(incinerateur);
    PlasticRecycler plasticRecycler = PlasticRecycler(kPlasticKey, servicesList[kPlasticKey]);
    manager.addService(plasticRecycler);
    PaperRecycler paperRecycler = PaperRecycler(kPaperKey, servicesList[kPaperKey]);
    manager.addService(paperRecycler);
    GlassRecycler glassRecycler = GlassRecycler(kGlassKey, servicesList[kGlassKey]);
    manager.addService(glassRecycler);
    MetalRecycler metalRecycler = MetalRecycler(kMetalKey, servicesList[kMetalKey]);
    manager.addService(metalRecycler);
    Composter composter = Composter(kOrganicKey, servicesList[kOrganicKey]);
    manager.addService(composter);

    /// Add wastes to Manager
    for (var district in data.districts!) {
      wasteList.update(kOtherKey, (value) => value + district.other!);
      wasteList.update(kPaperKey, (value) => value + district.paper!);
      wasteList.update(kGlassKey, (value) => value + district.glass!);
      wasteList.update(kMetalKey, (value) => value + district.metal!);
      wasteList.update(kOrganicKey, (value) => value + district.organic!);
    }

    Waste others = Waste(label: kOtherKey, quantity: wasteList[kOtherKey], burningCo2Rate: co2.other!.burnedGeneratedCo2);
    Recyclable paper = Recyclable(label: kPaperKey, quantity: wasteList[kPaperKey], burningCo2Rate: co2.paper!.burnedGeneratedCo2, recycleCo2Rate: co2.paper!.recycledGeneratedCo2);
    Recyclable glass = Recyclable(label: kGlassKey, quantity: wasteList[kGlassKey], burningCo2Rate: co2.glass!.burnedGeneratedCo2, recycleCo2Rate: co2.glass!.recycledGeneratedCo2);
    Recyclable metal = Recyclable(label: kMetalKey, quantity: wasteList[kMetalKey], burningCo2Rate: co2.metal!.burnedGeneratedCo2, recycleCo2Rate: co2.metal!.recycledGeneratedCo2);
    Organic organic = Organic(label: kOrganicKey, quantity: wasteList[kOrganicKey], burningCo2Rate: co2.organic!.burnedGeneratedCo2, compostCo2Rate: co2.organic!.compostedGeneratedCo2);
    
    manager.addWaste(others);
    manager.assignServiceToWaste(others, incinerateur);
    manager.addWaste(paper);
    manager.assignServiceToWaste(paper, paperRecycler);
    manager.addWaste(glass);
    manager.assignServiceToWaste(glass, glassRecycler);
    manager.addWaste(metal);
    manager.assignServiceToWaste(metal, metalRecycler);
    manager.addWaste(organic);
    manager.assignServiceToWaste(organic, composter);

    print(manager.getGlobalCo2().toString());

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


class Manager {

  Incinerateur? incinerateur;
  List<Service> recyclingServices = [];
  List<Waste> wastes = [];
  double recyclableWasteToBurn = 0;

  void setIncinerateur(Incinerateur newBurner) {
    incinerateur = newBurner;
  }

  void addService(Service service) {
    recyclingServices.add(service);
  }

  List<Service> getServices() {
    return recyclingServices;
  }

  void addWaste (Waste waste) {
    wastes.add(waste);
  }

  List<Waste> getWastes() {
    return wastes;
  }

  void assignServiceToWaste(Waste waste, Service service) {
    waste.setService(service);
  }

  /// Trial
  void assignWasteToAService(Service service, Waste waste) {
    service.setWaste(waste);
  }

  double? getGlobalCo2() {
    var globalCo2 = 0.0;
    /// Get emitted co2 for recyclables
    for (var waste in wastes) {
      if(waste is Recyclable) {
        globalCo2 = globalCo2 + waste.service!.capacity! * waste.recycleCo2Rate!;
      } else {
        globalCo2 = globalCo2 + waste.quantity! * waste.burningCo2Rate!;
    }
      return globalCo2;
    }


  }


}

abstract class Service {

  final String? name;
  final double? capacity;
  Waste? waste;

  Service({required this.name, required this.capacity});

  void setWaste(Waste newWaste) {
    waste = newWaste;
  }

}

class Incinerateur extends Service {

  final String? name;
  final double? capacity;

  Incinerateur(this.name, this.capacity) : super (name: name, capacity: capacity);

  double burnWaste(Waste waste) {
    return waste.burningCo2Rate! * capacity!;
  }

}

class PlasticRecycler extends Service {

  final String? name;
  final double? capacity;

  PlasticRecycler(this.name, this.capacity) : super (name: name, capacity: capacity);

  double recyclePlastic(Recyclable waste) {
    return waste.recycleCo2Rate! * capacity!;
  }

}

class PaperRecycler extends Service {

  final String? name;
  final double? capacity;

  PaperRecycler(this.name, this.capacity) : super (name: name, capacity: capacity);

  double recyclePaper(Recyclable waste) {
    return waste.recycleCo2Rate! * capacity!;
  }

}

class GlassRecycler extends Service {

  final String? name;
  final double? capacity;

  GlassRecycler(this.name, this.capacity) : super (name: name, capacity: capacity);

  double recycleGlass(Recyclable waste) {
    return waste.recycleCo2Rate! * capacity!;
  }


}

class MetalRecycler extends Service {

  final String? name;
  final double? capacity;

  MetalRecycler(this.name, this.capacity) : super (name: name, capacity: capacity);

  double recycleMetal(Recyclable waste) {
    return waste.recycleCo2Rate! * capacity!;
  }

}

class Composter extends Service {

  final String? name;
  final double? capacity;

  Composter(this.name, this.capacity) : super (name: name, capacity: capacity);

  double recycleOrganic(Recyclable waste) {
    return waste.recycleCo2Rate! * capacity!;
  }

}