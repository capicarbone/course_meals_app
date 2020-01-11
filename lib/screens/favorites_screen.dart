import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {

  final List<Meal> favoriteMeals;
  
  FavoritesScreen(this.favoriteMeals);

  Widget build(BuildContext context) {
    if ( favoriteMeals.isEmpty ){
      return Center(child: Text('You have no favorites yet - start adding more!',),);  
    }else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
            var meal =favoriteMeals[index];

            return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            affordability: meal.affordability,
            complexity: meal.complexity,            
          );
        },
      );
    }

    
  }
}