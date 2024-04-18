import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  //creating meal widget, needs meal data model as input
  const MealItem(
      {super.key, required this.meal, required this.onSelectedMeals});

  final Meal meal;
  final void Function(Meal meal) onSelectedMeals;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8), //space around card and screen
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, //cuts the parts of child widgets which are going outside of the boundary of the card widget
      elevation: 2, //adds a little bit of shadow effect
      child: InkWell(
        onTap: () {
          onSelectedMeals(
              meal); //its a function but with values using an anonymous function to pass parameters
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 250, //card height and width
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true, //text is wrapped around the parent
                        overflow: TextOverflow
                            .ellipsis, //tells us how the text will be cut off if it exceeds the space ellipsis makes the text look like this-> text...
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.access_time,
                              label: '${meal.duration} min'),
                          const SizedBox(
                            width: 10,
                          ),
                          MealItemTrait(
                              icon: Icons.work,
                              label: complexityText),
                          const SizedBox(
                            width: 10,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money_sharp,
                              label: affordabilityText),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
