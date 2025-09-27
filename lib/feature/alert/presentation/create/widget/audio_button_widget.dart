import 'dart:io';

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/create/widget/media_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../provider/alert_add_provider.dart';

class AudioButtonWidget extends StatefulWidget {
  const AudioButtonWidget({super.key});

  @override
  State<AudioButtonWidget> createState() => _AudioButtonWidgetState();
}

class _AudioButtonWidgetState extends State<AudioButtonWidget> {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;

  Future<String> _getFilePath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      final path = await _getFilePath();
      await _recorder.start(const RecordConfig(), path: path);
      setState(() {
        _isRecording = true;
      });
      print("On Record Start :: $path");
    }
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stop();
    print("On Record Stop :: $path");
    setState(() {
      _isRecording = false;
    });
    if (path != null) {
      context.read<AlertAddProvider>().selectedAudio = File(path);
    }
  }

  Future<void> _playAudio() async {
    String? filePath = context.read<AlertAddProvider>().selectedAudio?.path;
    if (filePath != null && File(filePath).existsSync()) {
      try {
        await _player.setFilePath(filePath);
        await _player.play();
        setState(() => _isPlaying = true);

        _player.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            setState(() => _isPlaying = false);
          }
        });
      } catch (e) {
        debugPrint("Error playing audio: $e");
      }
    }
  }

  Future<void> _stopAudio() async {
    await _player.stop();
    setState(() => _isPlaying = false);
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AlertAddProvider, File?>(
      selector: (_, provider) => provider.selectedAudio,
      builder: (_, value, _) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.bottomCenter,
        child: value == null
            ? MediaUploadButtonWidget(
                hintText: context.language.captureOrUploadImage,
                icon: _isRecording ? Icons.stop : Icons.mic,
                onTap: _isRecording ? _stopRecording : _startRecording,
              )
            : MediaViewFrameWidget(
                onClose: () =>
                    context.read<AlertAddProvider>().selectedVideo = null,
                child: ElevatedButton.icon(
                  icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                  label: Text(_isPlaying ? "Stop Playback" : "Play Recording"),
                  onPressed: _isPlaying ? _stopAudio : _playAudio,
                ),
              ),
      ),
    );
  }
}
