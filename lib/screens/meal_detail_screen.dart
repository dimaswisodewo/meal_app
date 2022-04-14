import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);

  static const routeName = 'meal-details';

  String getComplexityText(Complexity complexity) {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String getAffordabilityText(Affordability affordability) {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  Widget mealDetailsRow(bool isTrue, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        isTrue
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ]),
    );
  }

  Widget mealDetailsCheckBox(Meal meal) {
    return Column(
      children: [
        mealDetailsRow(meal.isGlutenFree, 'Gluten free'),
        mealDetailsRow(meal.isLactoseFree, 'Lactose free'),
        mealDetailsRow(meal.isVegan, 'Vegan food'),
        mealDetailsRow(meal.isVegetarian, 'Vegetarian food'),
      ],
    );
  }

  Widget mealDetailsContainer(String topText, String bottomText) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Text(
            topText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            bottomText,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> widgetIngredients(Meal meal) {
    return meal.ingredients.map((element) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '•  ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Flexible(
              child: Text(
                element,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> widgetSteps(Meal meal) {
    return meal.steps
        .asMap()
        .map(
          (key, value) => MapEntry(
            key,
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${key + 1}.   ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, widget, imageChunk) {
                    if (imageChunk == null) {
                      return widget;
                    }
                    return SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: imageChunk.expectedTotalBytes != null
                              ? imageChunk.cumulativeBytesLoaded /
                                  imageChunk.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      padding: const EdgeInsets.all(15),
                      color: Colors.red,
                      child: Text(error.toString()),
                    );
                  },
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 2,
                runSpacing: 2,
                children: [
                  Text(
                    meal.title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  mealDetailsContainer(
                    '${meal.duration} min',
                    'Duration',
                  ),
                  mealDetailsContainer(
                    getComplexityText(meal.complexity),
                    'Complexity',
                  ),
                  mealDetailsContainer(
                    getAffordabilityText(meal.affordability),
                    'Affordability',
                  ),
                ],
              ),
              const SizedBox(height: 45),
              mealDetailsCheckBox(meal),
              const SizedBox(height: 45),
              const Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ...widgetIngredients(meal), // Spread elements inside list
              const SizedBox(height: 45),
              // Steps
              const Text(
                'Steps',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ...widgetSteps(meal), // Spread elements inside list
            ],
          ),
        ),
      ),
    );
  }
}
