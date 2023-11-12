import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food_item.dart';
import '../models/food_diary_model.dart';

class FoodDiaryScreen extends StatefulWidget {
  const FoodDiaryScreen({super.key});

  @override
  FoodDiaryScreenState createState() => FoodDiaryScreenState();
}

class FoodDiaryScreenState extends State<FoodDiaryScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _sugarsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<FoodDiaryModel>(context, listen: false).loadFoodItems();
  }

  void _addFoodItem(BuildContext context) {
    final foodDiaryModel = Provider.of<FoodDiaryModel>(context, listen: false);
    final foodItem = FoodItem(
      itemName: _itemNameController.text,
      fats: double.parse(_fatsController.text),
      carbs: double.parse(_carbsController.text),
      proteins: double.parse(_proteinsController.text),
      calories: int.parse(_caloriesController.text),
      sugars: double.parse(_sugarsController.text),
    );

    foodDiaryModel.addFoodItem(foodItem);

    _itemNameController.clear();
    _fatsController.clear();
    _carbsController.clear();
    _proteinsController.clear();
    _caloriesController.clear();
    _sugarsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Diary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _itemNameController,
                    decoration:
                        const InputDecoration(labelText: 'Food Item Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a food item name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _fatsController,
                    decoration: const InputDecoration(labelText: 'Fats (g)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount of fats';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _carbsController,
                    decoration: const InputDecoration(labelText: 'Carbs (g)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount of carbs';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _proteinsController,
                    decoration:
                        const InputDecoration(labelText: 'Proteins (g)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount of proteins';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _caloriesController,
                    decoration: const InputDecoration(labelText: 'Calories'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the number of calories';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _sugarsController,
                    decoration: const InputDecoration(labelText: 'Sugars (g)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount of sugars';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _addFoodItem(context),
                    child: const Text('Add Food Item'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Previously Added Food Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<FoodDiaryModel>(
                builder: (context, foodDiaryModel, child) {
                  return ListView.builder(
                    itemCount: foodDiaryModel.foodItems.length,
                    itemBuilder: (context, index) {
                      final foodItem = foodDiaryModel.foodItems[index];
                      return ListTile(
                        title: Text(foodItem.itemName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fats: ${foodItem.fats}g'),
                            Text('Carbs: ${foodItem.carbs}g'),
                            Text('Proteins: ${foodItem.proteins}g'),
                            Text('Calories: ${foodItem.calories}'),
                            Text('Sugars: ${foodItem.sugars}g'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
