import 'dart:io';

import 'package:anamnesis/presentation/memory_screen/widgets/audio_player_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecordingsList extends StatefulWidget {
  List<String> recordingsList;
  RecordingsList({
    Key? key,
    required this.recordingsList,
  }) : super(key: key);

  @override
  RecordingsListState createState() => RecordingsListState();
}

class RecordingsListState extends State<RecordingsList> {
  List<String> recordingsList = [];
  void initState() {
    super.initState();
    recordingsList = widget.recordingsList;
  }

  void updateList(List<String>? recordingsList) {
    setState(() {
      this.recordingsList = recordingsList ?? this.recordingsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.recordingsList.isEmpty
            ? Text("No recordings yet.")
            : Column(
                children: widget.recordingsList
                    .map((path) => _buildRecordingBox(File(path)))
                    .toList(),
              )
      ],
    );
  }

  Widget _buildRecordingBox(File file) {
    return AudioPlayerWidget(
      audioPath: file.path,
      isAsset: false,
    );
  }
}
