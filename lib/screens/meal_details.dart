import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  //this class consumes the exposed value of provider
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  //final void Function(Meal meal) onSelectFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteStateNotifier);

    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteStateNotifier.notifier)
                    .toggleFavoriteStatus(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Meal was marked as Favorite'
                        : 'Removed from Favorites')));
              },
              icon: AnimatedSwitcher(      //to be used when we want to introduce a new child(ele) from an old child with some animation with duration
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation){    //here we state what kind of animation is needed for the child
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.8, end: 1).animate(animation),//tween is a generic type and animate just returns flutters implicit animation to turns which requires a animation.
                     child: child,);
                },
                child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),    //need to add a key as flutter cannot see the difference between changes in a widget of the same type(icon in this case, changes from 1 icon to another icon) hence key will tell flutter then the icon data has changed and that change will trigger the animation

                //here we have the old and new elements to show on a logic hence its easier to make this the child of AnimatedSwitcher if we provide only the new ele the old ele will fade out n new ele is faded in
              ) ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Steps Required To Prepare this Meal',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            for (int i = 0; i < meal.ingredients.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    'Step- ${i + 1}                ${meal.steps[i]}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            const SizedBox(
              height: 30,
            ),
            const Text('Ingredients Required To Prepare this Meal',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 15,
            ),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
