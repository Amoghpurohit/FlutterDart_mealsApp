import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meal_provider.dart';


enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}


class FiltersStateProvider extends StateNotifier<Map<Filter, bool>> {

  FiltersStateProvider() : super({       //initialization in this case its a map<Filter enum, bool>
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarian : false,
    Filter.vegan : false
  });

  void setFilters(Map<Filter, bool> updatedFilters){
    state = updatedFilters; //when this method is called, it will be called with a map of updated filters(bool = true) and then the state is overriden with new map 
  }

  void setFilter(Filter filter, bool isActive){
    state = {...state,      //state is basically map here and we are setting the map to a new map but with a copy of old k-v pairs(using the spread operator) but overriding with new filter provided with the method
      filter : isActive
  };
}
}

final filtersProvider = StateNotifierProvider<FiltersStateProvider, Map<Filter, bool>> ((ref) => FiltersStateProvider(),);


final filteredMealsProvider = Provider((ref){       //is dependent on mealProvider and filtersProvider, if they change filteredMealsProvider changes

  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
     if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;  //if filter is selected but meal doesnt match the filter (removed from the list)
     }
     if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
     }
     if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
     }
     if(activeFilters[Filter.vegan]! && !meal.isVegan){
      return false;
     }
     return true; // keep all other meals
  }).toList();

});