import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Widget _drawerItem(
    String title,
    IconData iconData,
    BuildContext ctx,
    String routeName,
  ) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.of(ctx).pushReplacementNamed(routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _drawerItem(
            'Categories',
            Icons.category,
            context,
            '/',
          ),
          _drawerItem(
            'Filters',
            Icons.settings,
            context,
            FiltersScreen.routeName,
          ),
        ],
      ),
    );
  }
}
