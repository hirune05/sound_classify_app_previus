import 'package:flutter/material.dart';
import 'dart:math';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_classify_app/controllers/recording_page_controller.dart';
import 'package:sound_classify_app/models/detail.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

// 音声認識のデータから音の大きさを取得する関数
double getSoundVolume() {
  // 音声認識のデータから音の大きさを取得する処理
  return Random().nextDouble();
}

class ArPage extends ConsumerWidget {
  const ArPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sounds = ref.watch(recordingProvider).detail?.sounds;
    return Scaffold(
      appBar: AppBar(title: const Text('AR')),
      body: ARKitSceneView(
        showFeaturePoints: true,
        enableTapRecognizer: true,
        planeDetection: ARPlaneDetection.horizontalAndVertical,
        onARKitViewCreated: (controller) =>
            _onARKitViewCreated(controller, sounds),
      ),
    );
  }

  void _onARKitViewCreated(
      ARKitController arkitController, Map<String, double>? sounds) {
    addSixNodes(arkitController, sounds);
  }

  void addSixNodes(
      ARKitController arkitController, Map<String, double>? sounds) {
    final dishVolume = sounds?['皿の音'];
    final electronicVolume = sounds?['機械音'];
    final fanVolume = sounds?['換気扇の音'];
    final keybordVolume = sounds?['キーボードの音'];
    final speakingVolume = sounds?['話し声'];
    addNode(arkitController, 'assets/glb/cone.glb', dishVolume!);
    addNode(arkitController, 'assets/glb/coral.glb', electronicVolume!);
    addNode(arkitController, 'assets/glb/mofu.glb', fanVolume!);
    addNode(arkitController, 'assets/glb/Rock.glb', keybordVolume!);
    addNode(arkitController, 'assets/glb/Rock2.glb', speakingVolume!);
  }

  void addNode(ARKitController arkitController, String url, double volume) {
    final position = vector.Vector3(
      Random().nextDouble() * 0.5,
      Random().nextDouble() * 0.5,
      Random().nextDouble() * 0.5,
    );

    // 音の大きさに応じてARオブジェクトの拡大率を設定
    double scale = 0.1 + volume * 0.05;

    final node = _getNodeFromFlutterAsset(position, scale, url);
    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(
          vector.Vector3 position, double scale, String url) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        url: url,
        scale: vector.Vector3(scale, scale, scale),
        position: position,
      );
}
