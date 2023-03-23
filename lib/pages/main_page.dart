import 'package:bmi_app/pages/bmi_page.dart';
import 'package:bmi_app/pages/history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = const [BMIPage(), HistoryPage()];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('IBMI'),
          backgroundColor: Colors.lime,
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'BMI'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'History'),
          ]),
          tabBuilder: ((context, index) {
            return CupertinoTabView(
              builder: (context) {
                return _tabs[index];
              },
            );
          }),
        ));
  }
}
