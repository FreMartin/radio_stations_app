import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerRadio extends StatefulWidget {
  const AudioPlayerRadio({super.key});

  @override
  State<AudioPlayerRadio> createState() => _AudioPlayerRadioState();
}

class _AudioPlayerRadioState extends State<AudioPlayerRadio> {

  final AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;
  String url = 'https://s2-webradio.rockantenne.de/alternative/stream/mp3';

  @override
  void initState(){
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        playerState = state;
      });
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
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
              playAudio(url);
            }
          },
        ),
      ),
    );
  }
}