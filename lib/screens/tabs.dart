
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kSelectedFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree:false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {    //makes ref(listener) globally available

  //final List<Meal> _favoriteMeals = [];
  //Map<Filter, bool> _selectedFilters = kSelectedFilters;

  // void _toggleFavoriteButton(Meal meal){
  //   final bool doesExist = _favoriteMeals.contains(meal);

  //   if(doesExist){
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       ScaffoldMessenger.of(context).clearSnackBars();
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meal is no longer a favorite')));
  //     });
      
  //   }else{
  //     setState(() {
  //        _favoriteMeals.add(meal);
  //        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marked as Favorite')));
  //     });
     
  //   }
  // }

  var selectScreenIndex = 0;
  void _selectScreen(index){
    setState(() {
      selectScreenIndex = index;
    });
  }

  
  void setScreen(String identifier) async {    //adding async await here because the back button may be pressed by user is not certain 
    if(identifier == 'Filter'){
      Navigator.of(context).pop();   
      //final res = 
      await Navigator.push<Map<Filter, bool>>(context, MaterialPageRoute(builder: (context)=>const FiltersScreen())); 
      // setState(() {
      //   _selectedFilters = res ?? kSelectedFilters; //fallback value of res is null ( ?? checks if value in front of it in null, calling setState because we need to update the _selectedFilters map
      // });
        //push is a generic type accepts any kind of parameter
    }else{
      Navigator.of(context).pop();  //we are already on the tabs screen hence we can just pop the drawer to get to tabs screen.
    }
  }


  @override
  Widget build(BuildContext context) {
    //final meals = ref.watch(mealProvider);   //ref.watch() returns the value exposed by the provider and rebuilds the widget when the value changes.
    final mealsAfterFilters = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(availableMeals: mealsAfterFilters,);
    var activeScreenTitle = 'Categories';

    if(selectScreenIndex == 1){
      final favoriteMeals = ref.watch(favoriteStateNotifier);
      activeScreen = MealsScreen(meals: favoriteMeals,);
      activeScreenTitle = 'Your Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: setScreen,),
      appBar: AppBar(
        title: Text(activeScreenTitle),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))
        ],
      ),
      body: activeScreen,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: selectScreenIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}