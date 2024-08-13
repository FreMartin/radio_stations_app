import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomPlayerButton extends StatelessWidget {
  const CustomPlayerButton({
    super.key,
    required this.playerState,
    required this.audioPlayer,
    required this.urlResolved,
  });

  final PlayerState playerState;
  final AudioPlayer audioPlayer;
  final String urlResolved;

  @override
  Widget build(BuildContext context) {
    return SpinPerfect(
      infinite: true,
      duration: const Duration(seconds: 5),
      child: IconButton(
        icon: Icon(
          playerState == PlayerState.playing
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_filled_rounded,
        ),
        iconSize: 70.0,
        onPressed: () {
          if (playerState == PlayerState.playing) {
            audioPlayer.pause();
          } else {
            audioPlayer.play(UrlSource(urlResolved));
          }
        },
      ),
    );
  }
}