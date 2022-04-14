import 'package:flutter/material.dart';

import '../widgets/category_item.dart';

import '../seeds/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 160,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        children: dummyCategories.map((data) {
          return CategoryItem(
            id: data.id,
            title: data.title,
            color: data.color,
          );
        }).toList(),
      ),
    );
  }
}
