import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:flutter/rendering.dart';
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

class FlyingHealthyFood extends sp.Node {
  final AssetsController assetsController = Get.find<AssetsController>();
  FlyingHealthyFood() {
    _addFlyingFood(
      assetsController.sprites['carrot.png']!,
      1,
    );
    _addFlyingFood(assetsController.sprites['coli.png']!, 1);
    _addFlyingFood(assetsController.sprites['paprika.png']!, 1);
  }

  final List<ParticleSystem> _food = <ParticleSystem>[];

  void _addFlyingFood(SpriteTexture texture, double distance) {
    ParticleSystem food = ParticleSystem(
      texture: texture,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(512.0, 512.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 150.0 / distance,
      speedVar: 50.0 / distance,
      startSize: 1.0 / distance,
      startSizeVar: 0.3 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 20.0 * distance,
      lifeVar: 10.0 * distance,
      emissionRate: 0.25,
      startRotationVar: 360.0,
      endRotationVar: 360.0,
      radialAccelerationVar: 10.0 / distance,
      tangentialAccelerationVar: 10.0 / distance,
    );
    food.position = const Offset(1024.0, 0.0);
    food.opacity = 0.0;

    _food.add(food);
    addChild(food);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _food) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}

class FlyingUnhealthyFood extends sp.Node {
  final AssetsController assetsController = Get.find<AssetsController>();
  FlyingUnhealthyFood() {
    _addFlyingFood(
      assetsController.sprites['pizza.png']!,
      1,
    );
    _addFlyingFood(assetsController.sprites['burger.png']!, 1);
    _addFlyingFood(assetsController.sprites['cake.png']!, 1);
  }

  final List<ParticleSystem> _food = <ParticleSystem>[];

  void _addFlyingFood(SpriteTexture texture, double distance) {
    ParticleSystem food = ParticleSystem(
      texture: texture,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(512.0, 512.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 150.0 / distance,
      speedVar: 50.0 / distance,
      startSize: 1.0 / distance,
      startSizeVar: 0.3 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 20.0 * distance,
      lifeVar: 10.0 * distance,
      emissionRate: 0.25,
      startRotationVar: 360.0,
      endRotationVar: 360.0,
      radialAccelerationVar: 10.0 / distance,
      tangentialAccelerationVar: 10.0 / distance,
    );
    food.position = const Offset(1024.0, 0.0);
    food.opacity = 0;

    _food.add(food);
    addChild(food);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _food) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}

enum Food {
  non,
  unhelthy,
  healthy,
}

class GymWorld extends NodeWithSize {
  final FlyingHealthyFood helthyfood = FlyingHealthyFood();
  final FlyingUnhealthyFood unhelthyfood = FlyingUnhealthyFood();
  GymWorld() : super(const Size(2048.0, 2048.0)) {
    final AssetsController assetsController = Get.find<AssetsController>();

    GymLayer gymbackground = GymLayer(
      image: assetsController.images['assets/images/background.jpg']!,
    );
    gymbackground.position = const Offset(512, 512);
    addChild(gymbackground);

    addChild(helthyfood);
    addChild(unhelthyfood);
  }
}
