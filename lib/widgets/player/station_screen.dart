import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:radio_app/infraestructure/models/radio_stations_model.dart';

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
/*
  @override
  void dispose(){
    stopAudio();
    audioPlayer.dispose();
    super.dispose();
  }
*/

  void playAudio(String url) {
    audioPlayer.play(UrlSource(url));
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  void stopAudio() {
    audioPlayer.stop();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        audioPlayer.stop();
        return true;
      },

      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 170, 215, 252),
        appBar: AppBar(
          title: Text(name),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
      
              const SizedBox(height: 50,),
      
              Card(
                color: const Color.fromARGB(255, 159, 199, 233),
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
              ),
      
              const SizedBox(height: 30,),
      
                Text('In this Radio Station you can enjoy of music like $genre', 
                  style: const TextStyle(
                    fontStyle: FontStyle.normal, 
                    fontFamily: 'Roboto',
                    fontSize: 15
                  ),
                ),
      
                const  SizedBox(height: 20,),
      
                const Text('Home Page:', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18
                        ),
                    ),
      
                Text(homePage, 
                        style: const TextStyle(
                        color: Color.fromARGB(255, 13, 94, 160),
                        fontWeight: FontWeight.bold, 
                        decoration: TextDecoration.underline,
                        decorationColor:Color.fromARGB(255, 13, 94, 160) ,
                        fontFamily: 'Roboto',
                        fontSize: 15
                      ),
                    ),
      
                const SizedBox(height: 50,),
      
                IconButton(
                  icon: Icon(
                    playerState == PlayerState.playing
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_filled_rounded,
                  ),
                  iconSize: 70.0,
                  onPressed: () {
                    if (playerState == PlayerState.playing) {
                      pauseAudio();
                    } else {
                      playAudio(urlResolved);
                    }
                  },
                ),
                
            ],
          ),
        )
        /*
        Stack(
        children: <Widget> [
          
          Positioned(
            top: 40,
            left: 120,
            child: SizedBox(
              height: 150,
              width: 150,
              child: widget.station.favicon.isNotEmpty
                ? Image.network(
                widget.station.favicon,
                fit: BoxFit.cover,
                )
                : Image.asset('assets/images/radio_detail.png')
              ) 
          ),
      
          Positioned(
            top: 200,
            left: 20,
            child: SizedBox(
              width: 250,
              child: Text(widget.station.name, 
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'Oxygen',
                  fontSize: 20
                ),
              ),            
            )
          ),
          Positioned(
            top: 250,
            left: 20,
            child: SizedBox(
              width: 250,
              child: Text('Radio Station from ${widget.station.country}', 
                style: const TextStyle(
                  fontStyle: FontStyle.italic, 
                  fontFamily: 'Oxygen',
                  fontSize: 15
                ),
              ),
            ),
          )
        ],
        )
        */
      ),
    );
    
 /*   
    
    Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: IconButton(
          icon: Icon(
            playerState == PlayerState.playing
                ? Icons.pause
                : Icons.play_arrow,
          ),
          iconSize: 64.0,
          onPressed: () {
            if (playerState == PlayerState.playing) {
              pauseAudio();
            } else {
              playAudio(urlResolved);
            }
          },
        ),
      ),
    );
    */
  }
  
}