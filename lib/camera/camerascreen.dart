import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({required this.cameras, Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraDescription _currentCamera;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Initialize with the first camera by default
    _currentCamera = widget.cameras.first;
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _controller = CameraController(
        _currentCamera,
        ResolutionPreset.ultraHigh,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      _initializeControllerFuture = _controller.initialize();
    } catch (e) {
      // Handle camera initialization error
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _switchCamera() async {
    // Find the index of the current camera in the cameras list
    int currentIndex = widget.cameras.indexOf(_currentCamera);
    // Calculate the index of the next camera
    int nextIndex = (currentIndex + 1) % widget.cameras.length;
    // Get the next camera description
    CameraDescription nextCamera = widget.cameras[nextIndex];

    // Dispose the current controller before switching to a new camera
    await _controller.dispose();

    setState(() {
      _currentCamera = nextCamera;
    });

    // Re-initialize the controller with the new camera
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                _switchCamera(); // Call _switchCamera when tapped
              },
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CameraPreview(_controller),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // While waiting for initialization to complete
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
