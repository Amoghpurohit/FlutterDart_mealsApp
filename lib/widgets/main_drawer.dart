
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/drawer_list_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blueAccent, Color.fromARGB(255, 33, 112, 249)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              )
            ),
            child: Row(
              children: [
                Icon(Icons.fastfood, size: 20,),
                SizedBox(width: 10,),
                Text('Cooking Up!!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ],
            )
            ),
            DrawerListTile(title: 'Meals', icon: Icons.restaurant, onSelectDrawerTile: onSelectScreen,),
            DrawerListTile(title: 'Filter', icon: Icons.settings, onSelectDrawerTile: onSelectScreen,),
        ],
      ),
    );
  }
}