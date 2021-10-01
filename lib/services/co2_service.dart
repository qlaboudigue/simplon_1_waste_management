import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:simplon_waste_management/models/json/json.dart';
import 'dart:convert';

class Co2Service {

  Future _loadACo2Asset() async {
    return await rootBundle.loadString('assets/co2.json');
  }

  Future<Co2> loadCo2() async {
    String jsonString = await _loadACo2Asset();
    final jsonResponse = json.decode(jsonString);
    Co2 co2 = Co2.fromJson(jsonResponse);
    return co2;
    // print(co2.plastic!.pEHD!.recycledGeneratedCo2);
  }


}