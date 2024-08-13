import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';

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