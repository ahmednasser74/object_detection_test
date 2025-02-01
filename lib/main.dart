import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/object_detection/presentation/provider/index.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjectSelectionProvider()),
        ChangeNotifierProvider(create: (_) => CameraStreamProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
