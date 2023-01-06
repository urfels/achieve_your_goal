import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:achieve_your_goal/view/home_screen.dart';
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
      life: HomeScreen.daySecondsController.value / 1000,
      lifeVar: 10.0 * distance,
      emissionRate: 6 / (HomeScreen.daySecondsController.value / 1000),
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
      life: HomeScreen.daySecondsController.value / 1000,
      lifeVar: 10.0 * distance,
      emissionRate: 6 / (HomeScreen.daySecondsController.value / 1000),
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

class RunningPunk extends sp.Node {
  final AssetsController assetsController = Get.find<AssetsController>();

  RunningPunk() {
    RunningPunkFrame run0 =
        RunningPunkFrame(assetsController.runPunkSprite['run0.png']!);
    run0.visible = false;
    addChild(run0);
    RunningPunkFrame run1 =
        RunningPunkFrame(assetsController.runPunkSprite['run1.png']!);
    run1.visible = false;
    addChild(run1);
    RunningPunkFrame run2 =
        RunningPunkFrame(assetsController.runPunkSprite['run2.png']!);
    run2.visible = false;
    addChild(run2);
    RunningPunkFrame run3 =
        RunningPunkFrame(assetsController.runPunkSprite['run3.png']!);
    run3.visible = false;
    addChild(run3);
    RunningPunkFrame run4 =
        RunningPunkFrame(assetsController.runPunkSprite['run4.png']!);
    run4.visible = false;
    addChild(run4);
    RunningPunkFrame run5 =
        RunningPunkFrame(assetsController.runPunkSprite['run5.png']!);
    run5.visible = false;
    addChild(run5);
    RunningPunkFrame run6 =
        RunningPunkFrame(assetsController.runPunkSprite['run6.png']!);
    run6.visible = false;
    addChild(run6);
    RunningPunkFrame run7 =
        RunningPunkFrame(assetsController.runPunkSprite['run7.png']!);
    run7.visible = false;
    addChild(run7);
  }
}

class RunningPunkFrame extends Sprite {
  String name;

  RunningPunkFrame(SpriteTexture texture, {this.name = ''})
      : super(texture: texture);
}

class WeightLifting extends sp.Node {
  final AssetsController assetsController = Get.find<AssetsController>();

  WeightLifting() {
    WeightLiftingFrame frame0 = WeightLiftingFrame(
        assetsController.weightLiftingSprite['bell0_sm.png']!);
    frame0.visible = false;
    addChild(frame0);
    WeightLiftingFrame frame1 = WeightLiftingFrame(
        assetsController.weightLiftingSprite['bell1_sm.png']!);
    frame1.visible = false;
    addChild(frame1);
    WeightLiftingFrame frame2 = WeightLiftingFrame(
        assetsController.weightLiftingSprite['bell2_sm.png']!);
    frame2.visible = false;
    addChild(frame2);
    WeightLiftingFrame frame3 = WeightLiftingFrame(
        assetsController.weightLiftingSprite['bell3_sm.png']!);
    frame3.visible = false;
    addChild(frame3);
    WeightLiftingFrame frame4 = WeightLiftingFrame(
        assetsController.weightLiftingSprite['belll4_sm.png']!);
    frame4.visible = false;
    addChild(frame4);
  }
}

class WeightLiftingFrame extends Sprite {
  String name;

  WeightLiftingFrame(SpriteTexture texture, {this.name = ''})
      : super(texture: texture);
}

class Sleep extends sp.Node {
  final AssetsController assetsController = Get.find<AssetsController>();

  Sleep() {
    SleepFrame frame0 = SleepFrame(assetsController.sleepSprite['sleep0.png']!);
    frame0.visible = false;
    addChild(frame0);
    SleepFrame frame1 = SleepFrame(assetsController.sleepSprite['sleep1.png']!);
    frame1.visible = false;
    addChild(frame1);
    SleepFrame frame2 = SleepFrame(assetsController.sleepSprite['sleep2.png']!);
    frame2.visible = false;
    addChild(frame2);
    SleepFrame frame3 = SleepFrame(assetsController.sleepSprite['sleep3.png']!);
    frame3.visible = false;
    addChild(frame3);
    SleepFrame frame4 = SleepFrame(assetsController.sleepSprite['sleep4.png']!);
    frame4.visible = false;
    addChild(frame4);
  }
}

class SleepFrame extends Sprite {
  String name;

  SleepFrame(SpriteTexture texture, {this.name = ''}) : super(texture: texture);
}

class BmiForm extends sp.Node {
  BmiForm();
}

class BmiFormSingle extends Sprite {
  String name;

  BmiFormSingle(SpriteTexture texture, {this.name = ''})
      : super(texture: texture);
}

class GymWorld extends NodeWithSize {
  final FlyingHealthyFood helthyFood = FlyingHealthyFood();
  final FlyingUnhealthyFood unhelthyFood = FlyingUnhealthyFood();
  final BmiForm bmiForm = BmiForm();
  final RunningPunk runningPunk = RunningPunk();
  final WeightLifting weightLifting = WeightLifting();
  final Sleep sleep = Sleep();
  GymWorld() : super(const Size(2048.0, 2048.0)) {
    final AssetsController assetsController = Get.find<AssetsController>();

    GymLayer gymbackground = GymLayer(
      image: assetsController.images['assets/images/background.jpg']!,
    );
    gymbackground.position = const Offset(512, 512);
    addChild(gymbackground);
    runningPunk.position = const Offset(1024, 1250);
    addChild(runningPunk);
    weightLifting.position = const Offset(1300, 1250);
    addChild(weightLifting);
    sleep.position = const Offset(1300, 1250);
    addChild(sleep);
    addChild(helthyFood);
    addChild(unhelthyFood);
    bmiForm.position = const Offset(80, 510);
    addChild(bmiForm);
  }
}
