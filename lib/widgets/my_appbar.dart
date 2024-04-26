import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passwordmanager/colors/colors.dart';
import 'package:passwordmanager/themes/theme_provider.dart';

import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller = TextEditingController();
  MyAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            'Main',
            style: TextStyle(
              fontFamily: 'Lato',
              color: sideMenuSelectedIconColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              // Add button with an icon
              Container(
                decoration: BoxDecoration(
                  color: sideMenuIconColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/plus.svg',
                      width: 20,
                      height: 20,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                    Text(
                      'ADD',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/down-arrow.svg',
                      width: 20,
                      height: 20,
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              // Search bar

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Adjust the value as needed
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  child: TextField(
                    cursorColor: Theme.of(context).colorScheme.onTertiary,
                    cursorWidth: 1,
                    controller: controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'OpenSans',
                      ),
                      border: InputBorder.none, // Hide the default border
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, // Adjust the padding as needed
                        vertical: 5, // Adjust the padding as needed
                      ),
                    ),
                  ),
                ),
              ),
               SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              // Toggle switch
              CupertinoSwitch(
                  activeColor: Theme.of(context).colorScheme.inversePrimary,
                  trackColor: Theme.of(context).colorScheme.onTertiary,
                  thumbColor: const Color(0xFFFF971D),
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              // Profile icon
              CircleAvatar(
                radius: 20,
                backgroundColor: sideMenuIconColor,
                child: SvgPicture.asset(
                  'assets/user-shield-alt-1.svg',
                  width: 20,
                  height: 20,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.onTertiary,
          thickness: 1,
        ),
      ],
    );
  }
}
