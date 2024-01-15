import 'package:anamnesis/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioPath;
  final bool isAsset;

  const AudioPlayerWidget({
    Key? key,
    this.audioPath = "recordings/work.mp3",
    this.isAsset = true,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;
  Duration totalDuration = Duration();
  Duration position = Duration();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        totalDuration = d;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    // Start playing the audio file with volume set to 0
    // This is done so that the widget can get the file duration
    audioPlayer.setVolume(0);

    if (widget.isAsset) {
      // If isAsset is true, play the audio from an asset
      audioPlayer.play(AssetSource(widget.audioPath)).then((_) {
        // Once the audio file has started playing, pause it
        audioPlayer.pause();
        // Reset the volume
        audioPlayer.setVolume(1);
      });
    } else {
      // If isAsset is false, play the audio from a file path
      audioPlayer.play(DeviceFileSource(widget.audioPath)).then((_) {
        // Once the audio file has started playing, pause it
        audioPlayer.pause();
        // Reset the volume
        audioPlayer.setVolume(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillDeepPurple.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      margin: EdgeInsets.symmetric(horizontal: 3.h),
      padding: EdgeInsets.only(left: 3.h, right: 16.h, top: 3.v, bottom: 3.v),
      child: Row(
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () async {
              setState(() {
                if (isPlaying) {
                  audioPlayer.pause();
                  isPlaying = false;
                } else {
                  // Conditionally play from asset or file path
                  if (widget.isAsset) {
                    audioPlayer.play(AssetSource(widget.audioPath));
                  } else {
                    audioPlayer.play(DeviceFileSource(widget.audioPath));
                  }
                  isPlaying = true;
                }
              });
            },
          ),
          Text(position.toString().substring(2, 7)),
          Expanded(
            child: Slider(
              thumbColor: Colors.deepPurple[300],
              activeColor: Colors.deepPurple[300],
              onChanged: (v) {
                final position = v * totalDuration.inMilliseconds;
                audioPlayer.seek(Duration(milliseconds: position.round()));
              },
              value: (position.inMilliseconds > 0 &&
                      totalDuration.inMilliseconds > 0)
                  ? position.inMilliseconds / totalDuration.inMilliseconds
                  : 0.0,
            ),
          ),
          Text(totalDuration.toString().substring(2, 7)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
