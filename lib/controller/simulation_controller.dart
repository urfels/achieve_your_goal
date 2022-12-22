import 'dart:async';
import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:achieve_your_goal/widgets/gymworld_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/person_model.dart';

class SimulationController extends GetxController
    with GetTickerProviderStateMixin {
  final RxInt movement = 1.obs;
  final RxInt bbgcIndex = 0.obs;
  final RxInt bbgcStopIndex = 1.obs;
  RxBool simulate = false.obs;

  Future<void> simulation(RxInt dayDuration, RxInt movementMinutes,
      RxInt colorIndex, RxInt tage, Rx<Person> person) async {
    if (simulate.value == false) {
      simulate.toggle();
    }
    while (simulate.value) {
      update();
      bbgcIndex.value = 1;
      bbgcStopIndex.value = 0;
      movement.value = movementMinutes.value.round();
      update();
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
      if (newWeight < person.value.weight) {
        final AssetsController assetsController = Get.find<AssetsController>();

        assetsController.gymWorld.value.helthyfood.active = true;
        assetsController.gymWorld.value.unhelthyfood.active = false;
        update();
      } else {
        final AssetsController assetsController = Get.find<AssetsController>();
        assetsController.gymWorld.value.helthyfood.active = false;
        assetsController.gymWorld.value.unhelthyfood.active = true;
        update();
      }
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
      update();
      tage.value++;

      await Future.delayed(Duration(milliseconds: dayDuration.value));
    }
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
    bbgcIndex.value = 0;
    bbgcStopIndex.value = 1;
    final AssetsController assetsController = Get.find<AssetsController>();
    assetsController.gymWorld.value.helthyfood.active = false;
    assetsController.gymWorld.value.unhelthyfood.active = false;
    update();
  }

  void updateVariables(person, kcal, trainEasy, trainMiddel, trainHard, pal) {
    person.value.kcalZufuhr = int.parse(kcal);
    person.value.trainingEasy = int.parse(trainEasy);
    person.value.trainigMiddel = int.parse(trainMiddel);
    person.value.trainingHard = int.parse(trainHard);
    person.value.pal = pal;
    update();
  }
}
