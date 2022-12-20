import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;
import 'package:spritewidget/spritewidget.dart' as sp;
// muss doppelt importiert werden ansnsten kann die klasse Node nicht richtig zugeordnet werden

class GymLayer extends sp.Node {
  GymLayer({
    required ui.Image image,
  }) {
    _sprites.add(_createSprite(image));
    _sprites[0].position = const Offset(500.0, 500.0);
    addChild(_sprites[0]);
  }
  final List<Sprite> _sprites = <Sprite>[];

  Sprite _createSprite(ui.Image image) {
    Sprite sprite = Sprite.fromImage(image);
    return sprite;
  }
}

class GymWorld extends NodeWithSize {
  GymWorld() : super(const Size(2048.0, 2048.0)) {
    final AssetsController assetsController = Get.find<AssetsController>();
    GymLayer gymbackground = GymLayer(
      image: assetsController.images['assets/images/fitnessstudio.png']!,
    );
    gymbackground.position = const Offset(512, 512);
    addChild(gymbackground);
  }
}
