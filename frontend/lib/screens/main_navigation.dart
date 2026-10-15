import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'transaction_screen.dart';
import 'ai_chat_screen.dart';
import 'parent_mode_screen.dart';


class MainNavigation
    extends StatefulWidget {

  const MainNavigation({
    super.key
  });


  @override
  State<MainNavigation>
      createState()
      =>
      _MainNavigationState();

}


class _MainNavigationState
    extends State<MainNavigation> {

  int currentIndex = 0;


  Widget currentPage() {

    switch (
      currentIndex
    ) {

      case 1:

        return const
            TransactionScreen();


      case 2:

        return const
            AIChatScreen();


      case 3:

        return const
            ParentModeScreen();


      default:

        return const
            HomeScreen();

    }

  }


  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body:
          currentPage(),


      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex:
            currentIndex,


        onTap:
            (index) {

          setState(() {

            currentIndex =
                index;

          });

        },


        type:
            BottomNavigationBarType
                .fixed,


        selectedItemColor:
            Colors.indigo,


        items:
            const [

          BottomNavigationBarItem(

            icon:
                Icon(
              Icons.home,
            ),

            label:
                "Home",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
              Icons.history,
            ),

            label:
                "History",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
              Icons.smart_toy,
            ),

            label:
                "AI",

          ),


          BottomNavigationBarItem(

            icon:
                Icon(
              Icons.family_restroom,
            ),

            label:
                "Parent",

          ),

        ],

      ),

    );

  }

}