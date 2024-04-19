import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordmanager/colors/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: sideMenuColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 87,
              child: SvgPicture.asset(
                'assets/lock-alt.svg',
                color: sideMenuIconColor,
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
