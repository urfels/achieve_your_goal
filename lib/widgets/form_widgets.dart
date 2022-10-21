import 'package:achieve_your_goal/view/home_screen.dart';
import 'package:achieve_your_goal/view/simulation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KcalFormField extends StatelessWidget {
  final TextEditingController kcalController;
  const KcalFormField({Key? key, required this.kcalController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50),
        width: 320,
        child: TextFormField(
          controller: kcalController,
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
        ));
  }
}

class AgeFormField extends StatelessWidget {
  final TextEditingController ageController;
  const AgeFormField({Key? key, required this.ageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 50),
        width: 320,
        child: TextFormField(
          controller: ageController,
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
        ));
  }
}

class SizeFormField extends StatelessWidget {
  final TextEditingController heightController;
  const SizeFormField({Key? key, required this.heightController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        width: 320,
        child: TextFormField(
          controller: heightController,
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
        ));
  }
}

class WeightFormField extends StatelessWidget {
  final TextEditingController weightController;
  const WeightFormField({Key? key, required this.weightController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        width: 320,
        child: TextFormField(
          controller: weightController,
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
        ));
  }
}

class PalFormField extends StatelessWidget {
  final double palController;
  PalFormField({Key? key, required this.palController}) : super(key: key);
  final List<double> palNumbers = [1.2, 1.5, 1.7, 1.9, 2.4];

  @override
  Widget build(BuildContext context) {
    return Container(
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
            HomeScreen.palController = value!;
            SimulationScreen.palController = value;
          }),
          items: palNumbers.map((double val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val.toString(),
              ),
            );
          }).toList(),
        ));
  }
}

class TrainingEasyFormField extends StatelessWidget {
  final TextEditingController trainingEasyController;
  const TrainingEasyFormField({Key? key, required this.trainingEasyController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        width: 320,
        child: Tooltip(
            textStyle: const TextStyle(
              fontSize: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.9),
            ),
            message:
                'Badminton, Softball,Tanzen(normal), Crosstrainer(langsam), Krafttrainig(mäßig), Wandern, Basketball, Radfahren(17km/h)',
            child: TextFormField(
              controller: trainingEasyController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte tragen Sie einen Wert ein';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Training leicht in min',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder()),
            )));
  }
}

class TrainingMiddelFormfield extends StatelessWidget {
  final TextEditingController trainingMiddelController;
  const TrainingMiddelFormfield(
      {Key? key, required this.trainingMiddelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        width: 320,
        child: Tooltip(
            textStyle: const TextStyle(
              fontSize: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.9),
            ),
            message:
                'Calisthenics, Schwimmen(mäßig), Seilspringen(langsam), Fußball, Joggen(8km/h), Radfahren(21km/h), Handball, Tennis',
            child: TextFormField(
              controller: trainingMiddelController,
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
                  labelText: 'Training moderat in min',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder()),
            )));
  }
}

class TrainingHardFormField extends StatelessWidget {
  final TextEditingController trainingHardController;
  const TrainingHardFormField({Key? key, required this.trainingHardController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        width: 320,
        child: Tooltip(
            textStyle: const TextStyle(
              fontSize: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.9),
            ),
            message:
                'Seilspringen(moderat), Schwimmen(schnell), Laufen(11km/h), Boxen, Radfahren(26km/h)',
            child: TextFormField(
              controller: trainingHardController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte tragen Sie einen Wert ein';
                }
                return null;
              },
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: const InputDecoration(
                  labelText: 'Training intensiv in min',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder()),
            )));
  }
}
