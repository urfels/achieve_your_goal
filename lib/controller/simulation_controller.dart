import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/person_model.dart';

class SimulationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxInt movement = 1.obs;
  late AnimationController animationcontroller;
  @override
  void onInit() {
    super.onInit();
    animationcontroller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: movement.value,
      ),
    );
  }

  RxBool simulate = true.obs;
  RxInt imageIndex = 0.obs;
  List<AssetImage> animatedImage = [
    const AssetImage('assets/images/fat.png'),
    const AssetImage('assets/images/medium_fat.png'),
    const AssetImage('assets/images/medium.png'),
    const AssetImage('assets/images/slim_middel.png'),
    const AssetImage('assets/images/slim.png')
  ];
  Future<void> simulation(RxInt dayDuration, RxInt movementMinutes,
      RxInt colorIndex, RxInt tage, Rx<Person> person) async {
    if (simulate.value == false) {
      simulate.toggle();
    }
    while (simulate.value) {
      int newMovementMinutes = calculateMovement(person, dayDuration);
      movementMinutes.value = newMovementMinutes;
      movement.value = movementMinutes.value;
      update();
      animationcontroller.reset();
      animationcontroller.forward();

      double basalmetabolism = await calculateBasalMetabolism(
          person.value.weight, person.value.height, person.value.age);
      double performanceTurnover =
          await calculatePerformanceTurnover(basalmetabolism, person.value.pal);
      double addedWeight = (person.value.kcalZufuhr / 7000);
      double usedKcal = await calculateKcalthrowSport(
          person.value.trainingEasy,
          person.value.trainigMiddel,
          person.value.trainingHard,
          person.value.weight);
      double newWeight =
          (person.value.weight - performanceTurnover + addedWeight - usedKcal)
              .toPrecision(2);
      person.update((val) {
        val!.weight = newWeight;
      });
      double newBmi =
          await calculateBmi(person.value.weight, person.value.height);
      person.update((val) {
        val!.bmi = newBmi;
      });
      int newcolorIndex = await calculatecolorIndex(newBmi);
      colorIndex.value = newcolorIndex;
      int newImageIndex = await calculateimageIndex(newBmi);
      imageIndex.value = newImageIndex;
      person.value.image = animatedImage[imageIndex.value];
      update();
      tage.value++;

      await Future.delayed(Duration(milliseconds: dayDuration.value));
    }
  }

  calculateMovement(Rx<Person> person, RxInt dayDuration) {
    double movePercentage = (person.value.trainingEasy +
            person.value.trainigMiddel +
            person.value.trainingHard) /
        1440 *
        60000 /
        100 /
        dayDuration.value;
    double movement = movePercentage * dayDuration.value;
    int newMovementMinutes = movement.toInt();
    return newMovementMinutes;
  }

  calculatecolorIndex(double bmi) {
    int index;
    if (bmi >= 35) {
      index = 0;
      return index;
    } else if (bmi >= 30) {
      index = 1;
      return index;
    } else if (bmi >= 25) {
      index = 2;
      return index;
    } else if (bmi >= 18.5) {
      index = 3;
      return index;
    } else {
      index = 1;
      return index;
    }
  }

  calculateimageIndex(double bmi) {
    int index;
    if (bmi >= 35) {
      index = 0;
      return index;
    } else if (bmi >= 30) {
      index = 1;
      return index;
    } else if (bmi >= 25) {
      index = 2;
      return index;
    } else {
      index = 3;
      return index;
    }
  }

  calculateBmi(double weight, int height) {
    double heightQuad = ((height / 100) * (height / 100));
    double bmi = (weight / heightQuad).toPrecision(2);
    return bmi;
  }

  kaloriesToWeight(kalories) {
    double weight = kalories / 7000;
    return weight;
  }

  calculateBasalMetabolism(double weight, int height, int age) {
    double basalMetabolism =
        655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    return basalMetabolism;
  }

  calculateKcalthrowSport(int easy, int middel, int hard, double weight) {
    double kcalEasy = (5.5 / 60 * easy * weight);
    double kcalMiddel = (8 / 60 * middel * weight);
    double kcalHard = (11 / 60 * hard * weight);
    double kcaltotal = (kcalEasy + kcalMiddel + kcalHard) / 7000;
    return kcaltotal;
  }

  calculatePerformanceTurnover(double basicMetabolism, double pal) {
    double performanceTurnover = (basicMetabolism * pal) / 7000;
    return performanceTurnover;
  }

  void stop() {
    simulate.toggle();
    animationcontroller.stop();
  }
}
