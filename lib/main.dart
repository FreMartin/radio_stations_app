import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_app/screens/radio_stations_screen.dart';

//import 'package:radio_app/widgets/player/audio_player_radio.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RadioStationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio App',
      debugShowCheckedModeBanner: false,
      home: RadioStationsScreen(),
    );
  }
}