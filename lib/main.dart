import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {

        var filter = true;

        if (_filters['gluten']){
          filter = filter && meal.isGlutenFree;
        }

        if (_filters['lactose']){
          filter = filter && meal.isLactoseFree;
        }

        if (_filters['vegan']){
          filter = filter && meal.isVegan;
        }

        if (_filters['vegetarian']){
          filter = filter && meal.isVegetarian;
        }

        return filter;

      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
      },
      onUnknownRoute: (setttings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      } ,
    );
  }
}
