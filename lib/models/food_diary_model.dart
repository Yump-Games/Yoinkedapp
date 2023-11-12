import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_item.dart';

class FoodDiaryModel extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<FoodItem> _foodItems = [];

  List<FoodItem> get foodItems => _foodItems;

  void addFoodItem(FoodItem foodItem) {
    _foodItems.add(foodItem);
    _firestore.collection('food_items').add(foodItem.toMap());
    notifyListeners();
  }

  Future<void> loadFoodItems() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('food_items').get();
      _foodItems =
          querySnapshot.docs.map((doc) => FoodItem.fromSnapshot(doc)).toList();
      notifyListeners();
    } catch (error) {
      print('Error loading food items: $error');
    }
  }
}
