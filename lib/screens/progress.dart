import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yoinkedapp/utils/indicator.dart';
import 'package:yoinkedapp/models/food_item.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int touchedIndex = 0;
  List<FoodItem> foodItems = [];
  double totalCarbs = 0;
  double totalFats = 0;
  double totalProteins = 0;
  double totalSugars = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromFirestore();
  }

  Future<void> _loadDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('food_items').get();
      foodItems =
          querySnapshot.docs.map((doc) => FoodItem.fromSnapshot(doc)).toList();
      _calculateTotalGrams();
      setState(() {});
    } catch (error) {
      print('Error loading food items from Firestore: $error');
    }
  }

  void _calculateTotalGrams() {
    for (var foodItem in foodItems) {
      totalCarbs += foodItem.carbs;
      totalFats += foodItem.fats;
      totalProteins += foodItem.proteins;
      totalSugars += foodItem.sugars;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(
                'Nutrient Distribution',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event,
                                  PieTouchResponse? pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: showingSections(),
                            // Add Legend
                            sectionOptions: ChartOptions(
                              // Include the SectionsOptions within ChartOptions
                              showLegends: true,
                              // Define Legend Styles
                              legendOptions: LegendOptions(
                                showLegendsInRow: true,
                                position: LegendPosition.right,
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    // Add Legend Labels
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _legendLabel('Carbs', Colors.blue),
                        _legendLabel('Fats', Colors.yellow),
                        _legendLabel('Proteins', Colors.orange),
                        _legendLabel('Sugars', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _legendLabel(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    double totalGrams = totalCarbs + totalFats + totalProteins + totalSugars;
    double carbsPercentage = (totalCarbs / totalGrams) * 100;
    double fatsPercentage = (totalFats / totalGrams) * 100;
    double proteinsPercentage = (totalProteins / totalGrams) * 100;
    double sugarsPercentage = (totalSugars / totalGrams) * 100;

    return [
      _generatePieChartSectionData(0, carbsPercentage, Colors.blue),
      _generatePieChartSectionData(1, fatsPercentage, Colors.yellow),
      _generatePieChartSectionData(2, proteinsPercentage, Colors.orange),
      _generatePieChartSectionData(3, sugarsPercentage, Colors.green),
    ];
  }

  PieChartSectionData _generatePieChartSectionData(
      int index, double percentage, Color color) {
    final isTouched = index == touchedIndex;
    final fontSize = isTouched ? 20.0 : 16.0;
    final radius = isTouched ? 110.0 : 100.0;
    final widgetSize = isTouched ? 55.0 : 40.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return PieChartSectionData(
      color: color,
      value: percentage,
      title: '${percentage.toStringAsFixed(1)}%', // Display percentage
      radius: radius,
      titleStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff),
        shadows: shadows,
      ),
      badgeWidget: _Badge(
        'assets/icons/ophthalmology-svgrepo-com.svg', // Use your indicator images
        size: widgetSize,
        borderColor: Colors.black38,
      ),
      badgePositionPercentageOffset: .98,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: const Center(
          //child: SvgPicture.asset(
          // svgAsset,                     THIS IS WHERE THE PI CHART INDICATOR IMAGES GO
          //  ),
          ),
    );
  }
}
