import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/colors/colors.dart';
import 'package:passwordmanager/models/menu_model.dart';
import 'package:passwordmanager/widgets/widgets.dart';

class SideMenu extends StatefulWidget {
  
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isLoading = false;
  int selectedIndex = 0;
  

  Future<void> logout() async {
    try {
      // Set loading state to true
      setState(() {
        isLoading = true;
      });

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Logging out...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      // Call the logout API
      AuthService authService = AuthService();
      final bool success = await authService.logout();

      // Close loading dialog
      Navigator.pop(context);

      if (success) {
        // Navigate to the login page after successful logout
        Get.offAllNamed('/');
      } else {
        // Show an error message if logout failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout Failed'),
            content: Text(
              'An error occurred while logging out. Please try again.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary,
                fontFamily: 'Lato',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close dialog
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if an error occurs
      Navigator.pop(context);
    } finally {
      // Set loading state to false
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = MenuModel.menuItems;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.onTertiary,
            width: 1,
          ),
        ),
      ),
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: MyLogo(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'SecurePass',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // list view builder for menu items
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? Theme.of(context).colorScheme.onTertiary
                          : Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          // Set the selected index
                          selectedIndex = index;
                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Icon(
                              menuItems[index].icon,
                              color: selectedIndex == index
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary // Change color if selected
                                  : Theme.of(context).colorScheme.onTertiary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Menu items
                          Text(
                            menuItems[index].title,
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onPrimary // Change color if selected
                                  : Theme.of(context).colorScheme.onTertiary,
                              fontSize: 16,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          // Logout button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: logout,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.logOut,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  const SizedBox(width: 10),
                  // Menu items

                  Text(
                    'Log out',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
