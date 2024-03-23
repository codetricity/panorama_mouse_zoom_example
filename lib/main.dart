import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: HomeScreen(
        title: 'Home',
      )),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<PanoramaState> _panoramaKey = GlobalKey();

  void _zoomIn() {
    final currentState = _panoramaKey.currentState;
    if (currentState != null) {
      double currentZoom = currentState.scene!.camera.zoom;
      currentState.setZoom(currentZoom + 0.5); // Adjust the zoom step as needed
    }
  }

  void _zoomOut() {
    final currentState = _panoramaKey.currentState;
    if (currentState != null) {
      double currentZoom = currentState.scene!.camera.zoom;
      currentState.setZoom(currentZoom - 0.5); // Adjust the zoom step as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                double yScroll = pointerSignal.scrollDelta.dy;
                if (yScroll <= 0) {
                  _zoomIn();
                }
                if (yScroll >= 0) {
                  _zoomOut();
                }
              }
            },
            child: PanoramaViewer(
              key: _panoramaKey,
              child: Image.asset('assets/room2.jpg'),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomInBtn",
                  onPressed: _zoomIn,
                  tooltip: 'Zoom In',
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10), // Space between buttons
                FloatingActionButton(
                  heroTag: "zoomOutBtn",
                  onPressed: _zoomOut,
                  tooltip: 'Zoom Out',
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
