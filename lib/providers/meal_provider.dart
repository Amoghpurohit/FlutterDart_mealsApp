
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/category_data.dart';

final mealProvider = Provider((ref) {    //this provider can be used where our meal lists are needed
  return dummyMeals; 
});

//Providers return a dynamic value (providers are capable of it)
//Providers can also provide methods to change the value