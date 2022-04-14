import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './seeds/dummy_data.dart';

import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/category_item_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/page_not_found_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filtersMap = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;

  void setFilters(Map<String, bool> newMap) {
    setState(() {
      filtersMap = newMap;

      _availableMeals = dummyMeals.where((element) {
        if (filtersMap['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (filtersMap['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (filtersMap['vegan']! && !element.isVegan) {
          return false;
        }
        if (filtersMap['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meal App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Poppins',
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Poppins',
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        // home: const CategoriesScreen(),
        initialRoute: '/', // Just another way to assign widget as home
        routes: {
          '/': (context) => const TabsScreen(),
          CategoryItemScreen.routeName: (context) => CategoryItemScreen(
                availableMeals: [..._availableMeals],
              ),
          MealDetailScreen.routeName: (context) => const MealDetailScreen(),
          FiltersScreen.routeName: (context) => FiltersScreen(
                currentFilters: filtersMap,
                saveFilters: setFilters,
              ),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (context) {
              return const PageNotFoundScreen();
            },
          );
        });
  }
}
