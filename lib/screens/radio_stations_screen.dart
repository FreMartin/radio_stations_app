import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';
import 'package:provider/provider.dart';


class RadioStationsScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  RadioStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioStationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Stations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomInputTextField(
              controller: _controller, 
              provider: provider
              ),
          ),
          const SizedBox(height: 15,),
          provider.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
              child: provider.stations.isEmpty
                  ? const Text('No stations found')
                  : ListView.builder(
                      itemCount: provider.stations.length,
                      itemBuilder: (context, index) {
                        final station = provider.stations[index];
                        return CustomCardItem(station: station);
                      },
                    ),
            ),
        ],
      ),
    );
  }
}

class CustomCardItem extends StatelessWidget {
  const CustomCardItem({
    super.key,
    required this.station,
  });

  final RadioStationsModel station;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: station.favicon.isNotEmpty 
          ? Image.network(station.favicon, width: 50, height: 50, fit: BoxFit.cover)
          : Image.asset('assets/images/radio_detail.png',width: 50, height: 50, fit: BoxFit.cover),
        title: Text(station.name,
        overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 6, 83, 147),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('From ${station.country}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
        onTap: () {
          context.push('/station', extra: station);
        },
      ),
    );
  }
}

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    required TextEditingController controller,
    required this.provider,
  }) : _controller = controller;

  final TextEditingController _controller;
  final RadioStationProvider provider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
      hintText: 'Type the genre',
      suffixIcon:  IconButton(
        icon: const Icon(Icons.search),
        iconSize: 40,
        onPressed: () {
          provider.fetchRadioStations(_controller.text);
        },
        ),
      
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    ),
    );
  }
}

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





