import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordmanager/colors/colors.dart';
import 'package:passwordmanager/themes/theme_provider.dart';
import 'package:passwordmanager/widgets/listpart.dart';
import 'package:provider/provider.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/plus.svg',
                          width: 20,
                          height: 20,
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'ADD',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        const SizedBox(width: 5),
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
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: 'Lato',
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 16,
                      ),
                      cursorColor: Theme.of(context).colorScheme.inversePrimary,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontFamily: 'Lato',
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/search-alt-2.svg',
                            color: Theme.of(context).colorScheme.onTertiary,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onTertiary,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onTertiary,
                              width: 0.5),
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
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Divider(
                color: sideMenuSelectedIconColor,
                thickness: 1,
              ),
            ),
            const Expanded(flex: 5, child: ListPart()),
            //three horizontal cards
            const SizedBox(
              height: 15,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PasswordsAnalysis(),
            ),

            const Expanded(
              child: QuickTips(),
            ),
            //three card links
            const Expanded(
              child: Row(
                children: [],
              ),
            ),
          ],
        ));
  }
}
