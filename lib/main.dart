import 'package:bmi_app/pages/main_page.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'IBMI',
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => const MainPage()},
      initialRoute: '/',
    );
  }
}
