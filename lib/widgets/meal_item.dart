import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';

import '../models/meal.dart';
import '../models/category.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.meal,
    required this.categories,
  }) : super(key: key);

  final Meal meal;
  final List<Category> categories;

  String get complexityText {
    switch (meal.complexity) {
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

  String get affordabilityText {
    switch (meal.affordability) {
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

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: meal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            // Top card
            Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      meal.imageUrl,
                      width: double.infinity,
                      height: 250,
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
                  ),
                  // Mask color
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(0, 0, 0, 54),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  // Texts
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.title,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        const SizedBox(height: 3),
                        Wrap(
                          runSpacing: 1.0,
                          children: meal.categories.map((item) {
                            return Container(
                              child: Text(
                                categories
                                    .firstWhere((element) => element.id == item)
                                    .title,
                              ),
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: categories
                                      .firstWhere(
                                          (element) => element.id == item)
                                      .color),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Bottom card
            Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${meal.duration} min',
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.work_outline_outlined,
                          size: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          complexityText,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          size: 20,
                        ),
                        const SizedBox(width: 1),
                        Text(
                          affordabilityText,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
