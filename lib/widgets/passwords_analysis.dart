import 'package:flutter/material.dart';
import 'package:passwordmanager/colors/colors.dart';

class PasswordsAnalysis extends StatelessWidget {
  const PasswordsAnalysis({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: sideMenuColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //saved passwords
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: sideMenuSelectedIconColor,
                    width: 1,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '28',
                      style: TextStyle(
                        color: sideMenuSelectedIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Saved Passwords',
                      style: TextStyle(
                        color: sideMenuSelectedIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //strong
              Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Padding(
                padding:  EdgeInsets.only(left:20, right:20, top:20, bottom:10),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '28',
                      style: TextStyle(
                        color: sideMenuSelectedIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Strong',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // weak
               Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Padding(
                padding:  EdgeInsets.only(left:20, right:20, top:20, bottom:10),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '28',
                      style: TextStyle(
                        color: sideMenuSelectedIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Weak',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //duplicate
              Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Padding(
                padding:  EdgeInsets.only(left:20, right:20, top:20, bottom:10),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '28',
                      style: TextStyle(
                        color: sideMenuSelectedIconColor,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Duplicate',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
