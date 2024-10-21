import 'package:flutter/material.dart';
import 'package:passwordmanager/screens/screens.dart';
import 'package:passwordmanager/widgets/sidemenu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Row(
        children: [
          Expanded(flex: 2, child: SideMenu()),
          Expanded(
            flex: 10,
            child: MainScreen(),
          ),
        ],
      ),
    );
  }
}
