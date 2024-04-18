import 'package:flutter/material.dart';

class Category{
  const Category({required this.id, required this.title, this.color = Colors.orangeAccent}); //fall back color incase none is defined, cannot use required with default values

  final String id;
  final String title;
  final Color color;
} 