
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';
import 'package:radio_app/presentation/widgets/station_screen/custom_genre_container.dart';
import 'package:radio_app/presentation/widgets/station_screen/custom_home_page_container.dart';
import 'package:radio_app/presentation/widgets/station_screen/custom_player_button.dart';
import 'package:radio_app/presentation/widgets/station_screen/custom_station_head_card.dart';

class StationScreen extends StatefulWidget {
  
  final RadioStationsModel station;
  const StationScreen({super.key, required this.station});
  

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;

  late final String name;
  late final String homePage;
  late final String favicon;
  late final String urlResolved;
  late final String country;
  late final String genre;

  @override
  void initState(){
    super.initState();
    name = widget.station.name;
    homePage = widget.station.homePage;
    favicon = widget.station.favicon;
    urlResolved = widget.station.urlResolved;
    country = widget.station.country;
    genre = widget.station.genre;
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        playerState = state;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        audioPlayer.stop();
        return true;
      },

      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 152, 153, 154),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 105, 23, 17),
          title: Text(
            name,
            style: const TextStyle(
              color: Color.fromARGB(255, 189, 183, 183)
            ),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
      
              const SizedBox(height: 50,),
      
              CustomStationHeadCard(favicon: favicon, name: name, country: country),
      
              const SizedBox(height: 30,),

              CustomGenreContainer(genre: genre),
      
              const  SizedBox(height: 20,),
      
              CustomHomePageContainer(homePage: homePage),
      
              const SizedBox(height: 50,),
      
              CustomPlayerButton(playerState: playerState, audioPlayer: audioPlayer, urlResolved: urlResolved),
                
            ],
          ),
        )
      ),
    );
  }
  
}






