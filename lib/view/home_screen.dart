import 'package:achieve_your_goal/controller/home_controller.dart';
import 'package:achieve_your_goal/view/simulation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/person_model.dart';
import '../widgets/form_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final List<double> palNumbers = [1.2, 1.5, 1.7, 1.9, 2.4];
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _kcalController = TextEditingController();
  final _trainingEasyController = TextEditingController();
  final _trainingMiddelController = TextEditingController();
  final _trainingHardController = TextEditingController();
  static double palController = 0;
  static RxInt daySecondsController = 0.obs;
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey.shade300,
      child: Center(
          child: Column(children: <Widget>[
        const Spacer(
          flex: 1,
        ),
        const Expanded(
          flex: 2,
          child: Text('Die Körpergewichts Simulation',
              style: TextStyle(fontSize: 40)),
        ),
        const Expanded(
          flex: 1,
          child: Text('Geben Sie die Daten für die Simulation ein.',
              style: TextStyle(fontSize: 20)),
        ),
        Expanded(
          flex: 12,
          child: Row(children: <Widget>[
            const Spacer(),
            Expanded(
                flex: 6,
                child: Form(
                  key: _formKey,
                  child: Row(children: <Widget>[
                    Column(children: <Widget>[
                      AgeFormField(ageController: _ageController),
                      SizeFormField(heightController: _heightController),
                      WeightFormField(weightController: _weightController),
                      PalFormField(palController: palController),
                    ]),
                    const Spacer(flex: 1),
                    Column(
                      children: <Widget>[
                        KcalFormField(kcalController: _kcalController),
                        TrainingEasyFormField(
                            trainingEasyController: _trainingEasyController),
                        TrainingMiddelFormfield(
                            trainingMiddelController:
                                _trainingMiddelController),
                        TrainingHardFormField(
                            trainingHardController: _trainingHardController),
                        DaySecondsFormField(
                            daySecondsController: daySecondsController.value),
                        Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        double bmi = controller.calculateBmi(
                                            double.parse(
                                                _weightController.text),
                                            int.parse(_heightController.text));

                                        Get.to(SimulationScreen(
                                            dayDuration: daySecondsController,
                                            person: Person(
                                              age: int.parse(
                                                  _ageController.text),
                                              height: int.parse(
                                                  _heightController.text),
                                              weight: double.parse(
                                                  _weightController.text),
                                              bmi: bmi,
                                              pal: palController,
                                              kcalZufuhr: int.parse(
                                                  _kcalController.text),
                                              trainingEasy: int.parse(
                                                  _trainingEasyController.text),
                                              trainigMiddel: int.parse(
                                                  _trainingMiddelController
                                                      .text),
                                              trainingHard: int.parse(
                                                  _trainingHardController.text),
                                            ).obs));
                                      }
                                    },
                                    child: const Text('Zur Simulation'))))
                      ],
                    )
                  ]),
                )),
            const Spacer(
              flex: 1,
            ),
          ]),
        )
      ])),
    ));
  }
}
