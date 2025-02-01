import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../features/object_detection/presentation/screens/index.dart';

class Routes {
  static const String splashScreen = '/splashScreen', cameraDetectionScreen = '/cameraDetectionScreen', resultScreen = '/resultScreen', objectSelectionScreen = '/objectSelectionScreen';

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    try {
      return switch (routeSettings.name) {
        splashScreen => _screenInit(const SplashScreen(), routeSettings),
        cameraDetectionScreen => _screenInit(
            CameraDetectionScreen(arg: routeSettings.arguments as ({String? objectName, List<CameraDescription> cameras})),
            routeSettings,
          ),
        objectSelectionScreen => _screenInit(const ObjectSelectionScreen(), routeSettings),
        resultScreen => _screenInit(
            ResultScreen(arg: routeSettings.arguments as ({String imagePath, String objectName})),
            routeSettings,
          ),
        _ => throw UnimplementedError('Given Named Route is not implemented yet'),
      };
    } catch (error) {
      throw UnimplementedError('Something went wrong while navigation check routes file ${error.toString()}');
    }
  }

  static MaterialPageRoute<dynamic> _screenInit(Widget screen, RouteSettings? settings) {
    return MaterialPageRoute<dynamic>(builder: (_) => screen, settings: settings);
  }
}
