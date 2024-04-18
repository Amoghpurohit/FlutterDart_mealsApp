import 'package:flutter/material.dart';
import 'package:meals_app/data/category_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  //final void Function(Meal meal) onSelectFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;    //late tells flutter that this property wont have a value when the class is created/built but will have a value before the build method is called

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0,
      upperBound: 1,
      );

      _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  void _selectedCategory(BuildContext context, Category category) {
    //in a stateless widget context is not available globally

    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController,
    child: GridView(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:3 / 2, //if height is 100px then width will be 100*3/2 = 150px
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in categoriesList)
          CategoryGridItem(
            category: category,
            onSelectedCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    ), //gridview main axis is top to bottom and cross axis is left to right,
    builder: (context, child){
      //here padding is the child meaning only padding is getting animated but Padding contains gridview hence only padding will be built 60 times per second not the entire gridview
      //So gridview is just part of the animation but isnt rebuilt due to animation(for performance reasons)
      //METHOD - 1(using padding logic according to lower and upper bounds)
      // return Padding(padding: EdgeInsets.only(
      //   top: 100 -  _animationController.value * 100), child: child,);   
      //METHOD - 2(using Slide Transition)
      return SlideTransition(position: Tween(  //so slideTransition takes place between these 2 offsets and animated in a curved manner
        begin: const Offset(0.0, 0.3),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)));
    });          //initially _animationController is equal to lowerbound i.e 0
                //so padding from top is 100 then at the end it is equal to upperbound within specified duration when upperbound is 1 then padding at top will be 100 - 100 =0
                //so its gonna slide upwards
  }
}
