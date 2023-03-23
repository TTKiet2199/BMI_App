import 'package:bmi_app/cards/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({Key? key}) : super(key: key);

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  int age = 20;
  double? deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        child: Center(
            child: InfoCard(
                width: deviceWidth! * 0.45,
                height: deviceHeight! * 0.18,
                child: ageSelect())));
  }

  Widget ageSelect() {
    return InfoCard(
        width: deviceWidth! * 0.45,
        height: deviceHeight! * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Age',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
            Text(
              age.toString(),
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
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
}
