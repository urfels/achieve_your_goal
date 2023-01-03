import 'package:achieve_your_goal/widgets/gymworld_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart';

class AssetsController extends GetxController {
  late BuildContext context;

  AssetsController({required this.context});
  late ImageMap images;
  RxBool assetsloaded = false.obs;
  late SpriteSheet sprites;
  late SpriteSheet sprites2;
  late SpriteSheet runPunkSprite;
  late Rx<GymWorld> gymWorld;

  @override
  void onInit() {
    super.onInit();

    AssetBundle bundle = rootBundle;

    // Load all graphics, then set the state to assetsLoaded and create the
    // WeatherWorld sprite tree
    loadAssets(bundle, context).then((_) {
      gymWorld = GymWorld().obs;
      assetsloaded.value = true;
      update();
    });
  }

  Future<void> loadAssets(AssetBundle bundle, BuildContext context) async {
    // Load images using an ImageMap
    images = ImageMap();
    await images.load(<String>[
      'assets/images/food.png',
      'assets/images/bmi_forms.png',
      'assets/images/background.jpg',
      'assets/images/runpunk.png',
    ]);
    // ignore: use_build_context_synchronously
    String json = await DefaultAssetBundle.of(context)
        .loadString('assets/images/foodspritesheet.json');
    sprites = SpriteSheet(
      image: images['assets/images/food.png']!,
      jsonDefinition: json,
    );
    // ignore: use_build_context_synchronously
    String json2 = await DefaultAssetBundle.of(context)
        .loadString('assets/images/bmi_forms_spritesheet.json');
    sprites2 = SpriteSheet(
      image: images['assets/images/bmi_forms.png']!,
      jsonDefinition: json2,
    );
    // ignore: use_build_context_synchronously
    String json3 = await DefaultAssetBundle.of(context)
        .loadString('assets/images/runpunkspritesheet.json');
    runPunkSprite = SpriteSheet(
      image: images['assets/images/runpunk.png']!,
      jsonDefinition: json3,
    );
  }
}
