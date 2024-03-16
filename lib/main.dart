import 'package:flutter/material.dart'; // JSON文字列を扱うために必要
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/main_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}
