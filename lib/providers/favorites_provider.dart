import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteStateNotifier extends StateNotifier<List<Meal>>{  //we tell the flutter riverpod what data is being managed by this StateNotifier
  FavoriteStateNotifier() : super([]);  // we cant add or remove from this list in StateNotifier class we can only create a new list everytime, after manipulation

  bool toggleFavoriteStatus(Meal meal){
    final isFavorite = state.contains(meal);  //state property holds the data(in this case List<Meal> ).
    if(isFavorite){
      state = state.where((m) => m.id != meal.id).toList();  //returns true if ele in list is not equal to provided ele(meaning a new ele is being added to list else existing ele is trying to get removed from list)
      return false;
    }else{
      state = [...state, meal];
      return true;   // existing list plus meal added to state
    }
  }
}

final favoriteStateNotifier = StateNotifierProvider<FavoriteStateNotifier, List<Meal>>((ref) {
  return FavoriteStateNotifier();
});