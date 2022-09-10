import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  calculateBmi(double weight, int height) {
    double heightQuad = ((height / 100) * (height / 100));
    double bmi = (weight / heightQuad).toPrecision(2);
    return bmi;
  }

  chooseImage(double bmi) {
    if (bmi > 34) {
      AssetImage image = const AssetImage('assets/images/fat.png');
      return image;
    } else if (bmi > 30) {
      AssetImage image = const AssetImage('assets/images/medium_fat.png');
      return image;
    } else if (bmi > 25) {
      AssetImage image = const AssetImage('assets/images/medium.png');
      return image;
    } else if (bmi > 20) {
      AssetImage image = const AssetImage('assets/images/slim_middel.png');
      return image;
    } else {
      AssetImage image = const AssetImage('assets/images/slim.png');
      return image;
    }
  }
}
