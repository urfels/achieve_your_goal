import 'package:achieve_your_goal/controller/home_controller.dart';
import 'package:achieve_your_goal/view/simulation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/person_model.dart';

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
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    late double palController;
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      const Spacer(
        flex: 1,
      ),
      const Expanded(
        flex: 2,
        child: Text('Achieve your Goals', style: TextStyle(fontSize: 40)),
      ),
      const Spacer(
        flex: 1,
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
                    Container(
                        padding: const EdgeInsets.only(top: 50),
                        width: 320,
                        child: TextFormField(
                          controller: _ageController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte tragen Sie ein Alter ein';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Alter in Jahren',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder()),
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: 320,
                        child: TextFormField(
                          controller: _heightController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte tragen Sie ihre Größe';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Größe in cm',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder()),
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: 320,
                        child: TextFormField(
                          controller: _weightController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte tragen Sie ihr Gewicht ein';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Gewicht in Kg',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder()),
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: 320,
                        child: DropdownButtonFormField<double>(
                          validator: (double? value) {
                            if (value == null || value.isNaN) {
                              return 'Bitte tragen Sie einen Wert ein.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'PAL Wert',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder()),
                          onChanged: ((value) {
                            palController = value!;
                          }),
                          items: palNumbers.map((double val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val.toString(),
                              ),
                            );
                          }).toList(),
                        ))
                  ]),
                  const Spacer(flex: 1),
                  Column(children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(top: 50),
                        width: 320,
                        child: TextFormField(
                          controller: _kcalController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Bitte tragen Sie einen Wert ein.';
                            }
                            return null;
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Kcal zufuhr',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder()),
                        )),
                    Column(
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(top: 20),
                            width: 320,
                            child: TextFormField(
                              controller: _trainingEasyController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bitte tragen Sie einen Wert ein';
                                }
                                return null;
                              },
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
                            padding: const EdgeInsets.only(top: 20),
                            width: 320,
                            child: TextFormField(
                              controller: _trainingMiddelController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bitte tragen Sie einen Wert ein.';
                                }
                                return null;
                              },
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
                            padding: const EdgeInsets.only(top: 20),
                            width: 320,
                            child: TextFormField(
                              controller: _trainingHardController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bitte tragen Sie einen Wert ein';
                                }
                                return null;
                              },
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
                            margin: const EdgeInsets.only(top: 30),
                            child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        double bmi = controller.calculateBmi(
                                            double.parse(
                                                _weightController.text),
                                            int.parse(_heightController.text));
                                        AssetImage image =
                                            controller.chooseImage(bmi);
                                        Get.to(SimulationScreen(
                                            person: Person(
                                          age: int.parse(_ageController.text),
                                          height:
                                              int.parse(_heightController.text),
                                          weight: double.parse(
                                              _weightController.text),
                                          bmi: bmi,
                                          image: image,
                                          pal: palController,
                                          kcalZufuhr:
                                              int.parse(_kcalController.text),
                                          trainingEasy: int.parse(
                                              _trainingEasyController.text),
                                          trainigMiddel: int.parse(
                                              _trainingMiddelController.text),
                                          trainingHard: int.parse(
                                              _trainingHardController.text),
                                        ).obs));
                                      }
                                    },
                                    child: const Text('Zur Simulation'))))
                      ],
                    )
                  ]),
                  const Spacer(
                    flex: 1,
                  ),
                ]),
              ))
        ]),
      )
    ])));
  }
}
