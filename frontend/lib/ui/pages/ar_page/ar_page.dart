import 'package:flutter/material.dart';
import 'dart:math';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

// 音声認識のデータから音の大きさを取得する関数
double getSoundVolume() {
  // 音声認識のデータから音の大きさを取得する処理
  return Random().nextDouble();
}

class ArPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AR')),
      body: ARKitSceneView(
        showFeaturePoints: true,
        enableTapRecognizer: true,
        planeDetection: ARPlaneDetection.horizontalAndVertical,
        onARKitViewCreated: (controller) => _onARKitViewCreated(controller),
      ),
    );
  }

  void _onARKitViewCreated(ARKitController arkitController) {
    addSixNodes(arkitController);
  }

  void addSixNodes(ARKitController arkitController) {
    addNode(arkitController, 'assets/glb/Tree.glb');
    addNode(arkitController, 'assets/glb/Tree.glb');
    addNode(arkitController, 'assets/glb/Tree.glb');
    addNode(arkitController, 'assets/glb/Tree.glb');
    addNode(arkitController, 'assets/glb/Tree.glb');
  }

  void addNode(ARKitController arkitController, String url) {
    final position = vector.Vector3(
      Random().nextDouble() * 0.5,
      Random().nextDouble() * 0.5,
      Random().nextDouble() * 0.5,
    );

    // 音声認識のデータから音の大きさを取得
    double volume = getSoundVolume();

    // 音の大きさに応じてARオブジェクトの拡大率を設定
    double scale = 0.1 + volume * 0.9;

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
