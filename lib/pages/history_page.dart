import 'package:bmi_app/cards/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  double? deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(child: _dataCard());
  }

  Widget _dataCard() {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prefs = snapshot.data as SharedPreferences;
            final date = prefs.getString('bmi_date');
            final data = prefs.getStringList('bmi_data');
            return Center(
              child: InfoCard(
                  width: deviceWidth! * 0.75,
                  height: deviceHeight! * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _statusText(data![1]),
                      _dateText(date!),
                      _bmiText(data[0])
                    ],
                  )),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.lightBlue,
              ),
            );
          }
        });
  }

  Widget _statusText(String status) {
    return Text(
      status,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _dateText(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return Text(
      '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}',
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
    );
  }
}
