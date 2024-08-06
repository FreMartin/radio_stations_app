import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';
import 'package:provider/provider.dart';


class RadioStationsScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

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
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
              hintText: 'Buscar',
              suffixIcon:  IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  provider.fetchRadioStations(_controller.text);
                },),
              
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            ),
          ),
          provider.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
              child: provider.stations.isEmpty
                  ? const Text('No stations found')
                  : ListView.builder(
                      itemCount: provider.stations.length,
                      itemBuilder: (context, index) {
                        final station = provider.stations[index];
                        debugPrint('Station: ${station.name}'); // Log de depuración
                        return ListTile(
                          leading: station.favicon.isNotEmpty 
                            ? Image.network(station.favicon, width: 50, height: 50, fit: BoxFit.cover)
                            : null,// Image.asset('assets/images/radio_default.jpg',width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(station.name),
                          subtitle: Text('${station.country} - ${station.urlResolved}'),
                          onTap: () {
                            // Acciones al seleccionar una estación
                          },
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}

class RadioStationProvider with ChangeNotifier {
  List<RadioStationsModel> _stations = [];
  bool _isLoading = false;

  List<RadioStationsModel> get stations => _stations;
  bool get isLoading => _isLoading;

  Future<void> fetchRadioStations(String genre) async {
    _isLoading = true;
    notifyListeners();

    try {
      var response = await Dio().get('https://de1.api.radio-browser.info/json/stations/search', queryParameters: {'tag': genre});
      if (response.statusCode == 200) {
        List jsonResponse = response.data;
        _stations = jsonResponse.map((station) => RadioStationsModel.fromJson(station)).toList();
        print('Number of stations fetched: ${_stations.length}'); // Log de depuración
      } else {
        throw Exception('Failed to load radio stations');
      }
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}




class SearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  SearchButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Search'),
    );
  }
}






