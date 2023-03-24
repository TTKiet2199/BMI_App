import 'dart:math';

import 'package:bmi_app/cards/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({Key? key}) : super(key: key);

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  int age = 20, weight = 80, height = 170, gender = 0;
  double? deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        child: SizedBox(
      height: deviceHeight! * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_ageSelect(), _weightSelect()],
          ),
          _heightSelect(),
          _genderSelecct(),
          _calculatateBmiButton(),
        ],
      ),
    ));
  }

  Widget _ageSelect() {
    return InfoCard(
        width: deviceWidth! * 0.45,
        height: deviceHeight! * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Age-yr',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            Text(
              age.toString(),
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 50,
                    child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          age--;
                        });
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    )),
                SizedBox(
                    width: 50,
                    child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          age++;
                        });
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ))
              ],
            )
          ],
        ));
  }

  Widget _weightSelect() {
    return InfoCard(
        width: deviceWidth! * 0.45,
        height: deviceHeight! * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Weight-kg',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            Text(
              weight.toString(),
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 50,
                    child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          weight--;
                        });
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    )),
                SizedBox(
                    width: 50,
                    child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          weight++;
                        });
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ))
              ],
            )
          ],
        ));
  }

  Widget _heightSelect() {
    return InfoCard(
        width: deviceWidth! * 0.9,
        height: deviceHeight! * 0.18,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text(
            'Height-cm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Text(
            height.toString(),
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          CupertinoSlider(
            min: 30,
            max: 300,
            divisions: 300,
            value: height.toDouble(),
            onChanged: ((value) {
              setState(() {
                height = value.toInt();
              });
            }),
          )
        ]));
  }

  Widget _genderSelecct() {
    return InfoCard(
        width: deviceWidth! * 0.9,
        height: deviceHeight! * 0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            CupertinoSlidingSegmentedControl(
                groupValue: gender,
                children: const {0: Text('male'), 1: Text('female')},
                onValueChanged: ((value) {
                  setState(() {
                    gender = value as int;
                  });
                }))
          ],
        ));
  }

  Widget _calculatateBmiButton() {
    return SizedBox(
      height: deviceHeight! * 0.07,
      child: CupertinoButton.filled(
          child: const Text('Calculate BMI'),
          onPressed: () {
            if (height > 0 && weight > 0 && age > 0) {
              double bmi = weight / pow(height / 100, 2);
              _showResultDialog(bmi);
            }
          }),
    );
  }

  void _showResultDialog(double bmi) {
    String? status;
    if (bmi < 18.5) {
      status = 'UnderWeight';
    }
    if (18.5 <= bmi && bmi < 25) {
      status = 'Nomal';
    }
    if (bmi < 30 && bmi >= 25) {
      status = 'OverWeight';
    }
    if (bmi >= 30) {
      status = 'Obese';
    }
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(status!),
            content: Text(bmi.toStringAsFixed(2)),
            actions: [
              CupertinoDialogAction(
                onPressed: (() {
                  _saveResult(bmi.toString(), status!);
                  Navigator.pop(context);
                }),
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  void _saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    await prefs.setStringList('bmi_data', <String>[bmi, status]);
    print('BMI result saved');
  }
}
