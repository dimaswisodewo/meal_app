import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
    required this.currentFilters,
    required this.saveFilters,
  }) : super(key: key);

  final Map<String, bool> currentFilters;
  final Function saveFilters;

  static const routeName = 'filters-screen';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGluten = false;
  bool isLactose = false;
  bool isVegan = false;
  bool isVegetarian = false;

  @override
  void initState() {
    isGluten = widget.currentFilters['gluten']!;
    isLactose = widget.currentFilters['lactose']!;
    isVegan = widget.currentFilters['vegan']!;
    isVegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  void _onSaveFilters(Map<String, bool> newFilters) {
    widget.saveFilters(newFilters);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.blueAccent,
      content: Text('Filters saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Map<String, bool> filtersMap = {
                  'gluten': isGluten,
                  'lactose': isLactose,
                  'vegan': isVegan,
                  'vegetarian': isVegetarian,
                };
                _onSaveFilters(filtersMap);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          ListTile(
            title: const Text(
              'Gluten',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            subtitle: const Text(
              'Only include gluten free food',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: CupertinoSwitch(
              value: isGluten,
              onChanged: (newValue) {
                setState(() {
                  isGluten = newValue;
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Lactose',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            subtitle: const Text(
              'Only include lactose free food',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: CupertinoSwitch(
              value: isLactose,
              onChanged: (newValue) {
                setState(() {
                  isLactose = newValue;
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Vegan',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            subtitle: const Text(
              'Only include vegan food',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: CupertinoSwitch(
              value: isVegan,
              onChanged: (newValue) {
                setState(() {
                  isVegan = newValue;
                });
              },
            ),
          ),
          ListTile(
            title: const Text(
              'Vegetarian',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            subtitle: const Text(
              'Only include vegetarian food',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            trailing: CupertinoSwitch(
              value: isVegetarian,
              onChanged: (newValue) {
                setState(() {
                  isVegetarian = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
