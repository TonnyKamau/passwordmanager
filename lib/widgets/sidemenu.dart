import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:passwordmanager/auth/auth_service.dart';
import 'package:passwordmanager/colors/colors.dart';
import 'package:passwordmanager/widgets/widgets.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isLoading = false;

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
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Logging out...',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
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
      print('Error during logout: $e');
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
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:  SizedBox(
                  width: 50,
                  height: 50,
                  child: MyLogo(),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Logout button
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
