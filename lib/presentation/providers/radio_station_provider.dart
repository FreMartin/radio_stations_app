import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';

class RadioStationProvider with ChangeNotifier {
  List<RadioStationsModel> _stations = [];
  bool _isLoading = false;
  final int maxParallelRequests = 10;
  final int stationLimit = 100; // Límite máximo de estaciones a recibir

  List<RadioStationsModel> get stations => _stations;
  bool get isLoading => _isLoading;

  Future<void> fetchRadioStations(String genre) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await Dio().get(
        'https://de1.api.radio-browser.info/json/stations/search',
        queryParameters: {
          'tag': genre,
          'limit': stationLimit // Limitar a 100 estaciones
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = response.data;

        // Validar URLs de las estaciones en paralelo con un límite
        _stations = await _validateStationsInParallel(jsonResponse);
      } else {
        throw Exception('Failed to load radio stations');
      }
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<List<RadioStationsModel>> _validateStationsInParallel(List<dynamic> jsonResponse) async {
    List<RadioStationsModel> validStations = [];

    for (int i = 0; i < jsonResponse.length; i += maxParallelRequests) {
      var chunk = jsonResponse.skip(i).take(maxParallelRequests).toList();

      List<Future<RadioStationsModel?>> futures = chunk.map((stationJson) async {
        RadioStationsModel station = RadioStationsModel.fromJson(stationJson);
        bool isValid = await _isValidStreamUrl(station.urlResolved);
        return isValid ? station : null;
      }).toList();

      List<RadioStationsModel?> results = await Future.wait(futures);
      validStations.addAll(results.whereType<RadioStationsModel>());
    }

    return validStations;
  }

  Future<bool> _isValidStreamUrl(String url) async {
    try {
      var dio = Dio();
      final response = await dio.head(url);
      if (response.statusCode == 200) {
        final contentType = response.headers['content-type']?.first;
        if (contentType != null && 
            (contentType.contains('audio/mpeg') || contentType.contains('audio/aacp'))) {
          return true;
        }
      }
    } catch (e) {
      print('Error al verificar la URL: $e');
    }
    return false;
  }
}
