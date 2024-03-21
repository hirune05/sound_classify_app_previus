import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/thems/app_theme.dart';
import 'package:sound_classify_app/ui/pages/page_router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext contest, WidgetRef ref) {
    return MaterialApp.router(
      title: 'SoundFit',
      theme: appTheme(contest),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
