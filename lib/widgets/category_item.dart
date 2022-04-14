import 'package:flutter/material.dart';

import '../screens/category_item_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  void openCategoryItemDetail(BuildContext ctx) {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return CategoryItemDetail(categoryItem: this);
    // }));

    Navigator.of(ctx).pushNamed(
      CategoryItemScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
        'color': color,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openCategoryItemDetail(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(title),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
