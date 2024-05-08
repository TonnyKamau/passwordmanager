import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
              ElevatedButton.icon(
                onPressed: () {
                // Add functionality here to show the dialog to add password
                  
                },
                icon: Icon(
                  LucideIcons.plus,
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                label: Text(
                  'Add',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              // Search bar

              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onTertiary,
                    cursorWidth: 1,
                    controller: controller,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: 'Lato',
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(LucideIcons.search,
                          color: Theme.of(context).colorScheme.onTertiary),
                      // Hide the default border
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
                  thumbColor: Theme.of(context).colorScheme.onPrimary,
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
