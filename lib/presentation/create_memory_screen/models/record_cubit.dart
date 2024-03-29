import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import './record_stat.dart' as mem;

class RecordCubit extends Cubit<mem.RecordState> {
  RecordCubit() : super(mem.RecordInitial());

  AudioRecorder _audioRecorder = AudioRecorder();

  void startRecording() async {
    Directory? appFolder =
        await pathProvider.getApplicationDocumentsDirectory();
    print(appFolder.path);
    bool appFolderExists =
        await Directory(appFolder.path + '/recordings').exists();
    if (!appFolderExists) {
      final created = await Directory(appFolder.path + '/recordings')
          .create(recursive: true);
      print(created.path);
    }

    final filepath = appFolder.path +
        '/recordings/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.m4a';
    print(filepath);

    final config = RecordConfig();

    await _audioRecorder.start(config, path: filepath);

    emit(mem.RecordOn());
  }

  Future<String?> stopRecording() async {
    String? path = await _audioRecorder.stop();
    emit(mem.RecordStopped());
    print('Output path $path');
    return path;
  }

  Stream<double> aplitudeStream() async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 100));
      final ap = await _audioRecorder.getAmplitude();
      yield ap.current;
    }
  }
}
