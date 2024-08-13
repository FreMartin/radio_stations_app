import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/presentation/providers/radio_station_provider.dart';
import 'package:radio_app/presentation/widgets/radio_stations_screen/custom_card_item.dart';
import 'package:radio_app/presentation/widgets/radio_stations_screen/custom_input_text_field.dart';


class RadioStationsScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  RadioStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioStationProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 153, 154),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 23, 17),
        title: const Text(
          'Radio Stations', 
          style: TextStyle(
            color: Color.fromARGB(255, 189, 183, 183)
          ),
        ),
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






