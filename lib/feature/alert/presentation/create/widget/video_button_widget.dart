import 'dart:async';
import 'dart:io';

import 'package:app/core/utils/extension/context_extension.dart';
import 'package:app/feature/alert/presentation/create/widget/media_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../provider/alert_add_provider.dart';

class VideoCaptureScreen extends StatefulWidget {
  const VideoCaptureScreen({super.key});

  @override
  State<VideoCaptureScreen> createState() => _VideoCaptureScreenState();
}

class _VideoCaptureScreenState extends State<VideoCaptureScreen> {
  VideoPlayerController? _controller;

  bool _isCompressing = false;
  bool _isPlaying = false;
  double _progress = 0.0;
  Subscription? _progressSub;

  @override
  void dispose() {
    _progressSub?.unsubscribe();
    _controller?.dispose();
    // best-effort to stop any ongoing compression when leaving the screen
    VideoCompress.cancelCompression();
    super.dispose();
  }

  Future<void> _pickAndCompressVideo() async {
    // Prevent re-entry right away
    if (_isCompressing) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Compression already in progress — please wait'),
        ),
      );
      return;
    }

    setState(() => _isCompressing = true);

    try {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 30),
      );

      // user cancelled
      if (picked == null) return;

      // Cancel any previous compression (safe-guard)
      try {
        await VideoCompress.cancelCompression();
      } catch (_) {
        // ignore
      }

      // Listen to progress stream (0..100)
      _progressSub?.unsubscribe();
      _progressSub = VideoCompress.compressProgress$.subscribe((event) {
        if (!mounted) return;
        setState(() => _progress = event / 100);
      });

      // Run compression (await the Future)
      final mediaInfo = await VideoCompress.compressVideo(
        picked.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
      );

      // stop listening to progress
      _progressSub?.unsubscribe();
      setState(() => _progress = 0.0);

      final File? compressedFile = mediaInfo?.file;
      if (compressedFile != null) {
        await _initializeVideo(compressedFile);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compression failed or returned null file'),
          ),
        );
      }
    } catch (e, st) {
      // helpful debug info
      debugPrint('Compression error: $e\n$st');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during compression: ${e.toString()}')),
      );
    } finally {
      // always reset flag
      if (mounted) setState(() => _isCompressing = false);
    }
  }

  Future<void> _initializeVideo(File file) async {
    // dispose any previous controller properly
    await _controller?.dispose();

    _controller = VideoPlayerController.file(file);
    await _controller!.initialize();
    if (!mounted) return;
    context.read<AlertAddProvider>().selectedVideo = file;
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _controller != null && _controller!.value.isInitialized;
    return Selector<AlertAddProvider, File?>(
      selector: (_, provider) => provider.selectedVideo,
      builder: (_, value, _) => AnimatedSize(
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.bottomCenter,
        child: _isCompressing
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    value: _progress > 0 ? _progress : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _progress > 0
                        ? '${(_progress * 100).toStringAsFixed(0)}%'
                        : '',
                  ),
                ],
              )
            : value == null
            ? MediaUploadButtonWidget(
                hintText: context.language.captureOrUploadImage,
                icon: Icons.videocam,
                onTap: _pickAndCompressVideo,
              )
            : MediaViewFrameWidget(
                child: isReady
                    ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            if (!_isPlaying) {
                              _controller!
                                ..setLooping(true)
                                ..play();
                              _isPlaying = true;
                            } else {
                              _controller!
                                ..setLooping(true)
                                ..pause();
                              _isPlaying = false;
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(4.r),
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                onClose: () =>
                    context.read<AlertAddProvider>().selectedVideo = null,
              ),
      ),
    );
  }
}
