import 'dart:async';
import 'dart:math';
import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:get/get.dart';
import '../models/person_model.dart';
import '../widgets/gymworld_widget.dart';
import 'package:spritewidget/spritewidget.dart' as sp;

class SimulationController extends GetxController
    with GetTickerProviderStateMixin {
  final RxInt movement = 1.obs;
  final RxInt bbgcIndex = 0.obs;
  final RxInt bbgcStopIndex = 1.obs;
  RxBool simulate = false.obs;

  Future<void> simulation(RxInt dayDuration, RxInt colorIndex, RxInt tage,
      Rx<Person> person) async {
    if (simulate.value == false) {
      simulate.toggle();
    }
    while (simulate.value) {
      bbgcIndex.value = 1;
      bbgcStopIndex.value = 0;
      update();

      double basalmetabolism = await calculateBasalMetabolism(
          person.value.weight, person.value.height, person.value.age);
      double performanceTurnover =
          await calculatePerformanceTurnover(basalmetabolism, person.value.pal);
      // kcal zufuhr mit Zufallsparameter wie anforderungsSpezifikation
      // um Schnwankungen im Essverhalten zu Simulieren
      double addedWeight =
          ((person.value.kcalZufuhr + randomInt(-300, 800)) / 7000);

      List sportTime = getSportTime(
        person.value.trainingEasy,
        person.value.trainigMiddel,
        person.value.trainingHard,
      );
      double trainEasy = sportTime[0];
      double trainMiddel = sportTime[1];
      double trainHard = sportTime[2];
      double usedKcal = await calculateKcalThrowSport(
          trainEasy, trainMiddel, trainHard, person.value.weight);
      double newWeight =
          (person.value.weight - performanceTurnover + addedWeight - usedKcal)
              .toPrecision(2);
      setFlyingFood(newWeight, person.value.weight);
      person.update((val) {
        val!.weight = newWeight;
      });
      double newBmi =
          await calculateBmi(person.value.weight, person.value.height);
      person.update((val) {
        val!.bmi = newBmi;
      });
      calculateBmiDependencies(newBmi, colorIndex);
      update();
      tage.value++;
      runPunk(
        dayDuration,
        simulate,
        person,
        trainEasy,
        trainMiddel,
        trainHard,
      );
      await Future.delayed(Duration(milliseconds: dayDuration.value));
    }
  }

  void calculateBmiDependencies(double bmi, RxInt colorIndex) {
    final AssetsController assetsController = Get.find<AssetsController>();
    if (bmi >= 35) {
      colorIndex.value = 0;
      assetsController.gymWorld.value.bmiForm.removeAllChildren();
      BmiFormSingle fat = addBmiFormSingle('fat_sm.png');
      assetsController.gymWorld.value.bmiForm.addChild(fat);

      update();
    } else if (bmi >= 30) {
      colorIndex.value = 1;
      assetsController.gymWorld.value.bmiForm.removeAllChildren();
      BmiFormSingle mediumFat = addBmiFormSingle('medium_fat_sm.png');
      assetsController.gymWorld.value.bmiForm.addChild(mediumFat);
      update();
    } else if (bmi >= 25) {
      colorIndex.value = 2;
      assetsController.gymWorld.value.bmiForm.removeAllChildren();
      BmiFormSingle medium = addBmiFormSingle('medium_sm.png');
      assetsController.gymWorld.value.bmiForm.addChild(medium);
      update();
    } else if (bmi >= 18.5) {
      colorIndex.value = 3;
      assetsController.gymWorld.value.bmiForm.removeAllChildren();
      BmiFormSingle slimMiddel = addBmiFormSingle('slim_middel_sm.png');
      assetsController.gymWorld.value.bmiForm.addChild(slimMiddel);
      update();
    } else {
      colorIndex.value = 1;
      assetsController.gymWorld.value.bmiForm.removeAllChildren();
      BmiFormSingle slim = addBmiFormSingle('slim_sm.png');
      assetsController.gymWorld.value.bmiForm.addChild(slim);
      update();
    }
  }

  calculateBmi(double weight, int height) {
    double heightQuad = ((height / 100) * (height / 100));
    double bmi = (weight / heightQuad).toPrecision(2);
    return bmi;
  }

  kaloriesToWeight(double kalories) {
    double weight = kalories / 7000;
    return weight;
  }

  calculateBasalMetabolism(double weight, int height, int age) {
    double basalMetabolism =
        655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    return basalMetabolism;
  }

  calculateKcalThrowSport(
      double easy, double middel, double hard, double weight) {
    double kcalEasy = (5.5 / 60 * easy * weight);
    double kcalMiddel = (8 / 60 * middel * weight);
    double kcalHard = (11 / 60 * hard * weight);
    double kcaltotal = (kcalEasy + kcalMiddel + kcalHard) / 7000;
    return kcaltotal;
  }

  // Gausschische Verteilte Zufallszahle eingebaut um trainings Zeiten
  //die Ausfallen und mal kürzer oder länger sind zu Simulieren
  getSportTime(
    int easy,
    int middel,
    int hard,
  ) {
    double trainEasy = easy * gaussianDistribution(2);
    double trainMiddel = middel * gaussianDistribution(2);
    double trainHard = hard * gaussianDistribution(2);
    return [trainEasy, trainMiddel, trainHard];
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
    assetsController.gymWorld.value.helthyFood.active = false;
    assetsController.gymWorld.value.unhelthyFood.active = false;
    update();
  }

  Future<void> runPunk(RxInt dayDuration, RxBool simulate, Rx<Person> person,
      double easy, double middel, double hard) async {
    final AssetsController assetsController = Get.find<AssetsController>();
    List<sp.Node> punkChildren =
        assetsController.gymWorld.value.runningPunk.children;
    List<sp.Node> lifterChildren =
        assetsController.gymWorld.value.weightLifting.children;
    List<sp.Node> sleepChildren =
        assetsController.gymWorld.value.sleep.children;
    double punkDuration = getPunkDuration(person, dayDuration);
    var i = 0;
    for (var x = 0; x < punkDuration;) {
      if (!simulate.value) {
        break;
      }
      punkChildren.elementAt(i).visible = true;
      update();
      int delay = 50;
      await Future.delayed(Duration(milliseconds: delay));
      punkChildren.elementAt(i).visible = false;
      i += 1;
      if (i >= punkChildren.length) {
        i = 0;
      }
      x += delay;
      update();
    }
    double weightDuration = getWeightDuration(easy, middel, hard, dayDuration);
    var y = 0;
    for (var z = 0; z < weightDuration;) {
      if (!simulate.value) {
        break;
      }
      lifterChildren.elementAt(y).visible = true;
      update();
      int delay = 50;
      await Future.delayed(Duration(milliseconds: delay));
      lifterChildren.elementAt(y).visible = false;
      y += 1;
      if (y >= lifterChildren.length) {
        y = 0;
      }
      z += delay;
      update();
    }
    var f = 0;
    double sleepDuration = dayDuration.value - (weightDuration + punkDuration);
    for (var c = 0; c < sleepDuration;) {
      if (!simulate.value) {
        break;
      }
      sleepChildren.elementAt(f).visible = true;
      update();
      int delay = 50;
      await Future.delayed(Duration(milliseconds: delay));
      sleepChildren.elementAt(f).visible = false;
      f += 1;
      if (f >= sleepChildren.length) {
        f = 0;
      }
      c += delay;
      update();
    }
  }

  getWeightDuration(
      double easy, double middel, double hard, RxInt dayDuration) {
    double trainingDuration = easy + middel + hard;
    double trainingPercent = ((trainingDuration * 100) / 1440) / 100;
    return trainingPercent * dayDuration.value;
  }

  void updateVariables(Rx<Person> person, String kcal, String trainEasy,
      String trainMiddel, String trainHard, double pal) {
    person.value.kcalZufuhr = int.parse(kcal);
    person.value.trainingEasy = int.parse(trainEasy);
    person.value.trainigMiddel = int.parse(trainMiddel);
    person.value.trainingHard = int.parse(trainHard);
    person.value.pal = pal;
    update();
  }

  int randomInt(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  double randomDouble(double max) {
    return Random().nextDouble() * max;
  }

  double gaussianDistribution(double max) {
    double randomGauss = (randomDouble(max) +
            randomDouble(max) +
            randomDouble(max) +
            randomDouble(max)) /
        4;
    return randomGauss;
  }

  void setFlyingFood(double newWeight, double weight) {
    if (newWeight < weight) {
      final AssetsController assetsController = Get.find<AssetsController>();
      assetsController.gymWorld.value.helthyFood.active = true;
      assetsController.gymWorld.value.unhelthyFood.active = false;
      update();
    } else {
      final AssetsController assetsController = Get.find<AssetsController>();
      assetsController.gymWorld.value.helthyFood.active = false;
      assetsController.gymWorld.value.unhelthyFood.active = true;
      update();
    }
  }

  BmiFormSingle addBmiFormSingle(String textureName) {
    final AssetsController assetsController = Get.find<AssetsController>();
    return BmiFormSingle(assetsController.sprites2[textureName]!,
        name: textureName);
  }

  getPunkDuration(Rx<Person> person, RxInt dayDuration) {
    if (person.value.pal == 1.2) {
      return 0.042 * dayDuration.value;
    } else if (person.value.pal == 1.5) {
      return 0.16 * dayDuration.value;
    } else if (person.value.pal == 1.7) {
      return 0.25 * dayDuration.value;
    } else if (person.value.pal == 1.9) {
      return 0.375 * dayDuration.value;
    } else {
      return 0.41 * dayDuration.value;
    }
  }
}
