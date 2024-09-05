import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn/pages/Home_Page.dart';
import 'package:learn/pages/navpages/search_page.dart';
import 'package:learn/provider/favorites_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0  ;
  void onTap(int index) {
   setState(() {
     currentIndex = index;
   });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      HomePage(),
      FavoritesPage(),
      SearchPage(),

    ];
    return Scaffold(
        backgroundColor: Colors.white,
      body : pages[currentIndex],
             bottomNavigationBar : BottomNavigationBar(
               type: BottomNavigationBarType.fixed,
               backgroundColor: Colors.white,
               onTap: onTap,
               currentIndex: currentIndex,
                 selectedItemColor: Colors.black54,
                 unselectedItemColor: Colors.grey.withOpacity(0.5),
                 showUnselectedLabels: false,
                 showSelectedLabels: false,
                 elevation: 0,
                 items: [
               BottomNavigationBarItem(label : "home", icon: Icon(Icons.apps)),
               BottomNavigationBarItem(label : "Favorite", icon: Icon(Icons.favorite_border)),
               BottomNavigationBarItem(label : "Search", icon:  ImageIcon(
                   AssetImage('assets/img/about.png'), // Replace with your image path
    )),

             ])
    );
  }
}
