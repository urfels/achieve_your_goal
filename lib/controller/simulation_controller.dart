import 'dart:async';

import 'package:get/get.dart';

import '../models/person_model.dart';

class SimulationController extends GetxController {
  RxBool simulate = true.obs;

  Future<void> simulation(tage, Rx<Person> person) async {
    if (simulate.value == false) {
      simulate.toggle();
    }
    while (simulate.value) {
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

      tage.value++;
      await Future.delayed(const Duration(seconds: 2));
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
    double kcalEasy = (7 / 60 * easy * weight);
    double kcalMiddel = (12 / 60 * middel * weight);
    double kcalHard = (16 / 60 * hard * weight);
    double kcaltotal = (kcalEasy + kcalMiddel + kcalHard) / 7000;
    return kcaltotal;
  }

  calculatePerformanceTurnover(double basicMetabolism, double pal) {
    double performanceTurnover = (basicMetabolism * pal) / 7000;
    return performanceTurnover;
  }

  void stop() {
    simulate.toggle();
  }
}
