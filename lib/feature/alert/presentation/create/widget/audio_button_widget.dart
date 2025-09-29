import 'dart:io';
import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/create/widget/media_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../provider/alert_add_provider.dart';

class AudioButtonWidget extends StatefulWidget {
  const AudioButtonWidget({super.key});

  @override
  State<AudioButtonWidget> createState() => _AudioButtonWidgetState();
}

class _AudioButtonWidgetState extends State<AudioButtonWidget> {
  late final RecorderController _recorderController;
  PlayerController? _waveController;

  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  Future<String> _getFilePath() async {
    final dir = await getTemporaryDirectory();
    return "${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
  }

  Future<void> _startRecording() async {
    final path = await _getFilePath();
    await _recorderController.record(path: path);
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    final path = await _recorderController.stop();
    setState(() => _isRecording = false);

    if (path != null && File(path).existsSync()) {
      context.read<AlertAddProvider>().selectedAudio = File(path);
    }
  }

  Future<void> _togglePlayPause(File file) async {
    if (_waveController == null) {
      _waveController = PlayerController();
      await _waveController!.preparePlayer(path: file.path);
      setState(() {});
    }

    if (_isPlaying) {
      await _waveController!.pausePlayer();
      setState(() => _isPlaying = false);
    } else {
      await _waveController!.startPlayer();
      setState(() => _isPlaying = true);

      _waveController!.onCompletion.listen((_) {
        setState(() => _isPlaying = false);
      });
    }
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _waveController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AlertAddProvider, File?>(
      selector: (_, provider) => provider.selectedAudio,
      builder: (_, file, __) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.bottomCenter,
        child: file == null
            ? _isRecording
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Live waveform while recording
                        AudioWaveforms(
                          enableGesture: false,
                          size: Size(
                            MediaQuery.of(context).size.width * 0.9,
                            100,
                          ),
                          recorderController: _recorderController,
                          waveStyle: const WaveStyle(
                            waveColor: Colors.blue,
                            extendWaveform: true,
                            showMiddleLine: false,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Stop button
                        MediaUploadButtonWidget(
                          hintText: "Stop Recording",
                          icon: Icons.stop,
                          onTap: _stopRecording,
                        ),
                      ],
                    )
                  : MediaUploadButtonWidget(
                      hintText: context.language.captureOrUploadImage,
                      icon: Icons.mic,
                      onTap: _startRecording,
                    )
            : MediaViewFrameWidget(
                onClose: () =>
                    context.read<AlertAddProvider>().selectedAudio = null,
                child: Row(
                  children: [
                    // Play / Pause button
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 48,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () => _togglePlayPause(file),
                    ),
                    const SizedBox(width: 20),
                    // Waveform of saved file
                    Expanded(
                      child: _waveController == null
                          ? const SizedBox.shrink()
                          : AudioFileWaveforms(
                              size: const Size(200, 70),
                              playerController: _waveController!,
                              enableSeekGesture: true,
                              waveformType: WaveformType.fitWidth,
                              playerWaveStyle: const PlayerWaveStyle(
                                fixedWaveColor: Colors.blueAccent,
                                liveWaveColor: Colors.green,
                                showSeekLine: true,
                                seekLineColor: Colors.red,
                                seekLineThickness: 2.0,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
