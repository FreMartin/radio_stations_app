import 'package:flutter/material.dart';

class CustomStationHeadCard extends StatelessWidget {
  const CustomStationHeadCard({
    super.key,
    required this.favicon,
    required this.name,
    required this.country,
  });

  final String favicon;
  final String name;
  final String country;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 189, 192, 194),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: favicon.isNotEmpty
                ? Image.network(
                favicon,
                fit: BoxFit.cover,
                )
                : Image.asset('assets/images/radio_detail.png')
              ),
                
            Text(name, 
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                fontFamily: 'Oxygen',
                fontSize: 20
              ),
            ),            
                
            Text('Radio Station from $country', 
              style: const TextStyle(
                fontStyle: FontStyle.italic, 
                fontFamily: 'Oxygen',
                fontSize: 15
              ),
            ), 
          ],
        ),
      ),
    );
  }
}