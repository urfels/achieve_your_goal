import 'package:achieve_your_goal/controller/simulation_controller.dart';
import 'package:achieve_your_goal/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SimulationScreen extends StatelessWidget {
  SimulationScreen({Key? key, required this.person}) : super(key: key);

  final SimulationController controller = Get.put(SimulationController());
  final _adjustFormKey = GlobalKey<FormState>();
  final RxInt dayDuration = 60000.obs;
  final RxInt tage = 0.obs;
  final Rx<Person> person;
  final RxInt colorIndex = 4.obs;
  final RxInt imageIndex = 0.obs;
  final RxInt movementMinutes = 0.obs;
  final List<Color> containerColor = [
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
                    Expanded(
                        flex: 2,
                        child: Obx(() => AnimatedContainer(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            color: containerColor[colorIndex.value],
                            duration: const Duration(seconds: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Obx(() => Text(
                                    'Gewicht in Kg: ${person.value.weight}')),
                                Obx(() => Text('BMI: ${person.value.bmi} ')),
                                Obx(() => Text('Tage:  ${tage.value}')),
                                Obx(() =>
                                    Text('Tage:  ${movementMinutes.value}')),
                              ],
                            )))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.simulation(
                                      dayDuration,
                                      movementMinutes,
                                      colorIndex,
                                      tage,
                                      person);
                                },
                                child: const Text('Simulation Starten')))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.stop();
                                },
                                child: const Text('Simulation stoppen')))),
                    Expanded(
                        flex: 7,
                        child: Form(
                            key: _adjustFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 0),
                                    width: double.infinity,
                                    child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        decoration: const InputDecoration(
                                            labelText: 'Kcal zufuhr',
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder()))),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 0),
                                    width: double.infinity,
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ],
                                      decoration: const InputDecoration(
                                          labelText: 'Training leicht in min',
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder()),
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 0),
                                    width: double.infinity,
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ],
                                      decoration: const InputDecoration(
                                          labelText: 'Training moderat in min',
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder()),
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 0),
                                    width: double.infinity,
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                      ],
                                      decoration: const InputDecoration(
                                          labelText: 'Training intensiv in min',
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder()),
                                    )),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        30, 20, 30, 0),
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Parameter updaten')))
                              ],
                            )))
                  ])),
              Expanded(
                  flex: 8,
                  child: Container(
                      height: 600,
                      child: Stack(
                        children: [
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
                        ],
                      )))
            ],
          ),
        )
      ],
    ));
  }
}
