import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Song extends StatefulWidget {
  const Song({super.key});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gnerate Music"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        player.pause();
                      } else {
                        player.play(AssetSource('RE.wav'));
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 25,
                  child: IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      player.stop();
                    },
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     player.play(AssetSource('theme_01.mp3'));
            //   },
            //   child: const Text('Play Audio'),
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       player.stop();
            //     },
            //     child: const Text('Stop Audio')),
            // ElevatedButton(
            //     onPressed: () {
            //       player.pause();
            //     },
            //     child: const Text('Pause ')),
            // ElevatedButton(
            //     onPressed: () {
            //       player.resume();
            //     },
            //     child: const Text('Resume')),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                player.seek(position);
                player.resume();
              },
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position.inSeconds)),
                  Text(formatTime((duration - position).inSeconds)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
