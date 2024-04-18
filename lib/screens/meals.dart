import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({this.title, required this.meals, super.key});

  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meal) onSelectFavorite;

  void _onSelectMeals(BuildContext context, Meal meal) {
    Navigator.push(context,MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No Meal Data Found',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Try selecting a different category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals
            .length, //builder only display items which are visible enhances performance
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectedMeals: (meal) {
            _onSelectMeals(context, meal);    //
          },  
        ),
      );
    }

    if(title == null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
