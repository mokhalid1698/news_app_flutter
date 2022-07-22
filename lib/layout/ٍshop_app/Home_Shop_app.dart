import 'package:flutter/material.dart';

class HomeShopApp extends StatelessWidget {
  const HomeShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salla", style: TextStyle(color: Colors.teal)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,

      ),
      body: const Center(
          child: Text(
        "Salla",
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
