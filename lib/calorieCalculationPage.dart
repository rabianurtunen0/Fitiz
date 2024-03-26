import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class CalorieCalculationPage extends StatefulWidget {
  const CalorieCalculationPage({super.key});

  @override
  State<CalorieCalculationPage> createState() => _CalorieCalculationPageState();
}

class _CalorieCalculationPageState extends State<CalorieCalculationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
      ),
      body: Center(child: Container(child: Text('Calorie Calculation Page'))),
    );
  }
}
