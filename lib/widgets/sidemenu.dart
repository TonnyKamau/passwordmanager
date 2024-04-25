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
      width: MediaQuery.of(context).size.width * 0.2,
      color: Theme.of(context).colorScheme.inversePrimary,
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
                'assets/lock.svg',
                color: sideMenuIconColor,
              ),
            ),
          ),
          const Spacer(),
          // log out
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/logout.svg',
                  color: sideMenuIconColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Log out',
                  style: TextStyle(
                    color: sideMenuIconColor,
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
