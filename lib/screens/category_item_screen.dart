import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/seeds/dummy_data.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryItemScreen extends StatelessWidget {
  static const String routeName = 'category-details';

  const CategoryItemScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meal> availableMeals;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments
        as Map<String, Object>; // get route arguments
    final categoryTitle = routeArgs['title'] as String;
    final categoryId = routeArgs['id'] as String;
    final categoryColor = routeArgs['color'] as Color;
    final categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: categoryColor,
        foregroundColor: Colors.white,
      ),
      body: categoryMeals.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return MealItem(
                  meal: categoryMeals[index],
                  categories: dummyCategories,
                );
              },
              itemCount: categoryMeals.length)
          : const Center(
              child: Text(
                'No items :(',
                style: TextStyle(color: Colors.black87),
              ),
            ),
    );
  }
}
