import 'package:an_core_ui/an_core_ui.dart';
import 'package:object_detection_test/core/constants/index.dart';
import 'package:object_detection_test/core/src/index.dart';
import 'package:flutter/material.dart';

import 'features/object_detection/presentation/screens/index.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(dimensions.width, dimensions.height),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: AppThemes().lightThemeData,
        home: const SplashScreen(),
        onGenerateRoute: Routes.onGenerateRoute,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: widget ?? Container(),
          );
        },
      ),
    );
  }

  ({double width, double height}) get dimensions {
    //use it instance of media query to avoid rebuilding while opening keyboard
    final double width = View.of(context).physicalSize.width;
    final double height = View.of(context).physicalSize.height;

    // Convert physical size to logical size (considering device pixel ratio)
    final double logicalWidth = width / View.of(context).devicePixelRatio;
    final double logicalHeight = height / View.of(context).devicePixelRatio;
    return (width: logicalWidth, height: logicalHeight);
  }
}
