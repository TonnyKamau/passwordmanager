import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passwordmanager/colors/colors.dart';
import 'package:passwordmanager/widgets/listpart.dart';

import '../widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDarkMode = false;
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
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'ADD',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/down-arrow.svg',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  // Search bar
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: sideMenuSelectedIconColor,
                      ), // Set text color to white
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          fontFamily: 'Lato',
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            'assets/search-alt-2.svg',
                            width: 30,
                            height: 30,
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ), // Adjust height
                        filled: true,
                        fillColor: backColor,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      cursorColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  // Toggle switch
                  Switch(
                    activeTrackColor: sideMenuIconColor,
                    inactiveTrackColor: backColor,
                    inactiveThumbColor: sideMenuColor,
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                        // Add your logic to change the theme here
                      });
                    },
                    activeColor: sideMenuSelectedIconColor,
                  ),
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
            const Expanded(child: ListPart()),
            //three horizontal cards
            const SizedBox(
              height: 20,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PasswordsAnalysis(),
            ),
          ],
        ));
  }
}

