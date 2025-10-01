import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AppLogic {
  /// Indicates which orientations the app will allow be default. Affects Android/iOS devices only.
  /// Defaults to both landscape (hz) and portrait (vt)
  List<DeviceOrientation> supportedOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  /// Allow a view to override the currently supported orientations. For example, [FullscreenVideoViewer] always wants to enable both landscape and portrait.
  /// If a view sets this override, they are responsible for setting it back to null when finished.
  List<DeviceOrientation>? _supportedOrientationsOverride;
  set supportedOrientationsOverride(List<DeviceOrientation>? value) {
    if (_supportedOrientationsOverride != value) {
      _supportedOrientationsOverride = value;
      _updateSystemOrientation();
    }
  }

  void handleAppSizeChanged(BuildContext context) {
    /// Disable landscape layout on smaller form factors
    bool isSmall = MediaQuery.of(context).size.shortestSide < 600;
    supportedOrientations = isSmall
        ? [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]
        : [
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ];
    _updateSystemOrientation();
  }

  void _updateSystemOrientation() {
    final orientations =
        _supportedOrientationsOverride ?? supportedOrientations;
    SystemChrome.setPreferredOrientations(orientations);
  }
}
