
import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({super.key, required this.title, required this.icon, required this.onSelectDrawerTile});

  final String title;
  final IconData icon;
  final void Function(String identifier) onSelectDrawerTile; 

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onBackground,),
      title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      onTap: (){
        onSelectDrawerTile(title);
      }
    );
  }
}