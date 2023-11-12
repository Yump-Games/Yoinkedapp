import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItem {
  final String itemName;
  final double fats;
  final double carbs;
  final double proteins;
  final int calories;
  final double sugars;

  FoodItem({
    required this.itemName,
    required this.fats,
    required this.carbs,
    required this.proteins,
    required this.calories,
    required this.sugars,
  });

  // Convert FoodItem to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'fats': fats,
      'carbs': carbs,
      'proteins': proteins,
      'calories': calories,
      'sugars': sugars,
    };
  }

  // Create FoodItem from Firestore document snapshot
  factory FoodItem.fromSnapshot(DocumentSnapshot snapshot) {
    return FoodItem(
      itemName: snapshot['itemName'],
      fats: snapshot['fats'],
      carbs: snapshot['carbs'],
      proteins: snapshot['proteins'],
      calories: snapshot['calories'],
      sugars: snapshot['sugars'],
    );
  }
}
