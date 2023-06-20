import 'package:city_clean/src/app.dart';
import 'package:flutter/material.dart';
import 'src/core/dependency_inyection/inyection.dart';

void main() async {
  await DependencyInyection.init();
  runApp(const MyApp());
}
