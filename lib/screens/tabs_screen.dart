import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedNavBarItemIndex = 0;

  final List<Widget> _widgets = const [
    CategoriesScreen(),
    FavoritesScreen(),
  ];

  void _selectNavigationBarItem(int index) {
    setState(() {
      _selectedNavBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Meals',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedNavBarItemIndex,
        onTap: _selectNavigationBarItem,
      ),
      body: _widgets[_selectedNavBarItemIndex],
    );
  }
}
