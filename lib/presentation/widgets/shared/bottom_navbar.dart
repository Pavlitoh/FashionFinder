import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatelessWidget {
  final index;

  const BottomNavbar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      height: 50,
      color: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.black,
      items: [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.map_outlined, color: Colors.white),
        Icon(Icons.map_outlined, color: Colors.white),
        Icon(Icons.map_outlined, color: Colors.white),
        Icon(Icons.map_outlined, color: Colors.white),
      ],
      onTap: (value){
        context.go("/home/$value");
        print(value.toString());
        // switch(value){
        //   case 0: 
        //     context.go("/home/0");
        //   break;

        //   case 1:
        //     context.go("/home/1");
        //   break;
        // }
      },
    );
  }
}