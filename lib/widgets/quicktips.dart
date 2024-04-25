import 'package:flutter/material.dart';

import '../colors/colors.dart';

class QuickTips extends StatelessWidget {
  const QuickTips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Divider(
              color: sideMenuIconColor,
              thickness: 1,
            ),
          ),
          SizedBox(width: 10),  
          Text(
            'Quick Tips',
            style: TextStyle(
              color: sideMenuIconColor,
              fontFamily: 'Lato',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              color: sideMenuIconColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
