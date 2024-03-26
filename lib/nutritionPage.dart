import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:fitiz/calorieCalculationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text('Nutrition Page'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const CalorieCalculationPage());
        },
        elevation: 4.0,
        focusElevation: 0.0,
        highlightElevation: 4.0,
        backgroundColor: Color(0XFF8DB600),
        splashColor: Color(0XFF8DB600),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: SvgPicture.asset(
          'assets/images/camera_viewfinder.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.09,
          height: MediaQuery.of(context).size.width * 0.09,
        ),
      ),
    );
  }
}
