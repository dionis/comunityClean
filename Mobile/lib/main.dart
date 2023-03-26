import 'package:city_clean/src/app.dart';
import 'package:flutter/material.dart';
import 'src/core/dependency_inyection/inyection.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}
