# Panorama Zoom

Control zoom of `panorama_viewer` with mouse wheel.

```dart
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
```
