import 'package:achieve_your_goal/controller/assets_controller.dart';
import 'package:achieve_your_goal/controller/simulation_controller.dart';
import 'package:achieve_your_goal/models/person_model.dart';
import 'package:achieve_your_goal/widgets/form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart';

class SimulationScreen extends StatelessWidget {
  SimulationScreen({Key? key, required this.person, required this.dayDuration})
      : super(key: key);

  static double palController = 0;
  final _kcalController = TextEditingController();
  final _trainingEasyController = TextEditingController();
  final _trainingMiddelController = TextEditingController();
  final _trainingHardController = TextEditingController();
  final SimulationController controller = Get.put(SimulationController());
  final _adjustFormKey = GlobalKey<FormState>();
  final List<double> palNumbers = [1.2, 1.5, 1.7, 1.9, 2.4];
  final RxInt dayDuration;
  final RxInt tage = 0.obs;
  final Rx<Person> person;
  final RxInt colorIndex = 4.obs;
  final RxInt imageIndex = 0.obs;
  late RxInt movementMinutes = (dayDuration.value / 2).round().obs;
  final List<dynamic> containerColor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.white
  ];

  final RelativeRectTween relativeRectTween = RelativeRectTween(
    begin: const RelativeRect.fromLTRB(500, 0, 0, 0),
    end: const RelativeRect.fromLTRB(0, 0, 0, 0),
  );

  @override
  Widget build(BuildContext context) {
    final AssetsController assetsController =
        Get.put(AssetsController(context: context));
    final List buttonbgcolor = [
      MaterialStateProperty.all<MaterialColor>(Colors.blue),
      MaterialStateProperty.all<MaterialColor>(Colors.grey),
    ];
    return Scaffold(
        body: Column(
      children: <Widget>[
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 8,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(children: <Widget>[
                    Obx(() => AnimatedContainer(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        color: containerColor[colorIndex.value],
                        duration: const Duration(seconds: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Obx(() =>
                                Text('Gewicht in Kg: ${person.value.weight}')),
                            Obx(() => Text('BMI: ${person.value.bmi} ')),
                            Obx(() => Text('Tage:  ${tage.value}')),
                            Obx(() => Text('Tage:  ${controller.movement}')),
                          ],
                        ))),
                    Container(
                        margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        width: double.infinity,
                        child: Obx(() => ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  buttonbgcolor[controller.bbgcIndex.value],
                            ),
                            onPressed: () {
                              if (controller.simulate.value != true) {
                                controller.simulation(dayDuration,
                                    movementMinutes, colorIndex, tage, person);
                              }
                            },
                            child: const Text('Simulation Starten')))),
                    Container(
                        margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        width: double.infinity,
                        child: Obx(() => ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  buttonbgcolor[controller.bbgcStopIndex.value],
                            ),
                            onPressed: () {
                              if (controller.simulate.value == true) {
                                controller.stop();
                              }
                            },
                            child: const Text('Simulation stoppen')))),
                  ])),
              Obx(() => Expanded(
                  flex: 7,
                  child: (assetsController.assetsloaded.value == false)
                      ? const SizedBox()
                      : Container(
                          height: 600,
                          child: Stack(
                            children: [SpriteWidget(assetsController.gymWorld)],
                          )))),
              Expanded(
                  flex: 2,
                  child: Form(
                      key: _adjustFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          KcalFormField(kcalController: _kcalController),
                          TrainingEasyFormField(
                              trainingEasyController: _trainingEasyController),
                          TrainingMiddelFormfield(
                              trainingMiddelController:
                                  _trainingMiddelController),
                          TrainingHardFormField(
                              trainingHardController: _trainingHardController),
                          PalFormField(palController: palController),
                          Container(
                            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            width: double.infinity,
                            child: Obx(() => ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      buttonbgcolor[controller.bbgcIndex.value],
                                ),
                                onPressed: () {
                                  if (controller.simulate.value != true &&
                                      _adjustFormKey.currentState!.validate()) {
                                    controller.updateVariables(
                                        person,
                                        _kcalController.text,
                                        _trainingEasyController.text,
                                        _trainingMiddelController.text,
                                        _trainingHardController.text,
                                        palController);
                                  }
                                },
                                child: const Text('Parameter updaten'))),
                          )
                        ],
                      ))),
            ],
          ),
        )
      ],
    ));
  }
}

/*
                          PositionedTransition(
                              rect: relativeRectTween
                                  .animate(controller.animationcontroller)
                                ..addListener(() {
                                  controller.update();
                                }),
                              child: Obx(() => AnimatedContainer(
                                    height: 600,
                                    width: 600,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: person.value.image,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    duration: Duration(
                                        milliseconds: movementMinutes.value),
                                  )))
                      */