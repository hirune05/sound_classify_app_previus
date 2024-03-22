import 'package:flutter/material.dart';
import 'dart:math';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

// 音声認識のデータから音の大きさを取得する関数
double getSoundVolume() {
  // 音声認識のデータから音の大きさを取得する処理
  return Random().nextDouble();
}

/*class ArPage extends ConsumerWidget {
  const ArPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR'),
      ),
      body: const Center(),
    );
  }
}*/

class ArPage extends StatefulWidget {
  const ArPage({Key? key}) : super(key: key);
  @override
  State<ArPage> createState() => _MyArAppState();
}

class _MyArAppState extends State<ArPage> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Christmas Decorations')),
        body: ARKitSceneView(
          showFeaturePoints: true,
          enableTapRecognizer: true,
          planeDetection: ARPlaneDetection.horizontalAndVertical,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    // 音声認識のデータから音の大きさを取得
    double volume = getSoundVolume();

    // 音の大きさに応じてARオブジェクトの拡大率を設定
    double scale = 0.1 + volume * 0.9;

    final node = _getNodeFromFlutterAsset(position, scale);
    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(
          vector.Vector3 position, double scale) =>
      ARKitGltfNode(
        assetType: AssetType.flutterAsset,
        url: 'assets/glb/Tree.glb',
        scale: vector.Vector3(scale, scale, scale),
        position: position,
      );
}
