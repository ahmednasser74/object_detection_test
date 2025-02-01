import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@module
abstract class RegisterModule {
  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}
