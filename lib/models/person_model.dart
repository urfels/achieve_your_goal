import 'package:flutter/cupertino.dart';

class Person {
  int age;
  int height;
  double weight;
  double bmi;
  AssetImage image;
  double pal;
  int kcalZufuhr;
  int trainingEasy;
  int trainigMiddel;
  int trainingHard;

  Person(
      {required this.age,
      required this.height,
      required this.weight,
      required this.bmi,
      required this.image,
      required this.pal,
      required this.kcalZufuhr,
      required this.trainingEasy,
      required this.trainigMiddel,
      required this.trainingHard});
}
