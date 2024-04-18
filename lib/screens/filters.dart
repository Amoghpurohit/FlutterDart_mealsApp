import 'package:flutter/material.dart';
import 'package:meals_app/widgets/switch_list_tile.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {  //(to be a consumer is to able to read providers )
  const FiltersScreen({super.key,});

  //final Map<Filter, bool> filterData;     //provides the Filters with their bool values

  //final void Function(String iden) setScreenForFilters;


  // var _glutenFreeFilterSet = false;           //widget.filterData;  is not available in the instance variables, only available in the methods or build method
  // var _lactoseFreeFilterSet = false;
  // var _vegetarianFilterSet = false;
  // var _veganFilterSet = false;           //false-> these values are hardcoded hence they are reset everytime we visit the screen
  
  // @override
  // void initState() {
  //   super.initState();
  //   final activeState = ref.read(filtersProvider);  // returns a map<Filter enum, bool>
  //   // _glutenFreeFilterSet = widget.filterData[Filter.glutenFree]!;
  //   _glutenFreeFilterSet = activeState[Filter.glutenFree]!;  //wont be null
  //   // _lactoseFreeFilterSet = widget.filterData[Filter.lactoseFree]!;
  //   _lactoseFreeFilterSet = activeState[Filter.lactoseFree]!;
  //   // _vegetarianFilterSet = widget.filterData[Filter.vegetarian]!;
  //   _vegetarianFilterSet = activeState[Filter.vegetarian]!;
  //   // _veganFilterSet = widget.filterData[Filter.vegan]!;
  //   _veganFilterSet = activeState[Filter.vegan]!;
    
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {     //use WidgetRef ref in a stateless widget here ref is globally accessible
    final filterOperation = ref.watch(filtersProvider);
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: ((identifier) {
       
      //   if(identifier == 'Meals'){
      //     Navigator.of(context).pop();
      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const TabsScreen()));
      //   }else{
      //     Navigator.of(context).pop();
      //   }
      // })),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: 
      // PopScope(
      //   canPop: false,
      //   onPopInvoked: (bool didPop) async {
      //     ref.read(filtersProvider.notifier).setFilters({
      //         Filter.glutenFree : _glutenFreeFilterSet,
      //         Filter.lactoseFree: _lactoseFreeFilterSet,
      //         Filter.vegetarian: _vegetarianFilterSet,
      //         Filter.vegan: _veganFilterSet,  
      //       });
      //     if(didPop) return;

      //     Navigator.of(context).pop(      //this map will be popped after we leave the screen meaning, we take or save this data from this screen and leave and use that in the next screen OR Filters screen returns this map when its popped(back button is pressed) and this data can be accessed in tabs screen as going back from this screen leads us to tabs screen
            
      //     );
      //   },
        Column(
          children: [
            SwitchListTile(
              value: filterOperation[Filter.glutenFree]!,  //takes a bool value (acts as initial value and stored value later on)
              onChanged: (isSwitched){   //takes a void function(bool)
                //setState(() {
                  //_glutenFreeFilterSet = isSwitched;
                  ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, isSwitched); 
                //});                      //isSwitched representes the changed value of the switch
              },     
              title: Text(
                'Gluten-free option',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.onBackground,
              subtitle: const Text('This provides the meals without gluten'),
            ),
        
            CustomSwitchListTile(title: 'Lactose-free', subtitle: 'Only includes lactose-free meals', value: filterOperation[Filter.lactoseFree]!, onChanged: (isSwitched){
              //setState(() {
                //_lactoseFreeFilterSet = isSwitched;
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isSwitched);
              //});
            }),
        
            CustomSwitchListTile(title: 'Vegetarian', subtitle: 'Only includes Vegetarian meals', value: filterOperation[Filter.vegetarian]!, onChanged: (isSwitched){
              //setState(() {
                //_vegetarianFilterSet = isSwitched;
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isSwitched);
              //});
            }),
        
            CustomSwitchListTile(title: 'Vegan', subtitle: 'Only includes Vegan meals', value: filterOperation[Filter.vegan]!, onChanged: (isSwitched){
              //_veganFilterSet = isSwitched;
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isSwitched);
            })
          ],
        ),
    );
  }
}
