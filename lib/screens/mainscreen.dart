import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            //recently added
            Expanded(flex: 5, child: ListPart()),
            //three horizontal cards
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PasswordsAnalysis(),
            ),

            Expanded(
              child: QuickTips(),
            ),
            //three card links
            Expanded(
              child: Row(
                children: [],
              ),
            ),
          ],
        ));
  }
}
