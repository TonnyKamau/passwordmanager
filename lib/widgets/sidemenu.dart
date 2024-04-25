import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/colors/colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isLoading = false;
  Future<void> logout() async {
    try {
      // Show logout dialog with loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            elevation: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Logging out...',
                      style: TextStyle(color: Theme.of(context).colorScheme.onTertiary,),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

      AuthService authService = AuthService();
      final bool success = await authService.logout();

      // Close logout dialog
      Navigator.of(context).pop();

      if (success) {
        // Navigate to the login page after successful logout
        Get.offAllNamed('/');
      } else {
        // Show an error message if logout failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout Failed'),
            content:
                Text('An error occurred while logging out. Please try again.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontFamily: 'OpenSans',
                ),
                ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close dialog
                child: Text('OK',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Theme.of(context).colorScheme.onTertiary,
                ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
      // Close logout dialog if an error occurs
      Navigator.of(context).pop();
    }
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: logout,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/logout.svg',
                    color: sideMenuIconColor,
                  ),
                  const SizedBox(width: 10),
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
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
