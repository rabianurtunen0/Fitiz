import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class NutritionDayReport extends StatefulWidget {
  final String breakfastDescription;
  final int breakfastCalories;
  final String snack1Description;
  final int snack1Calories;
  final String lunchDescription;
  final int lunchCalories;
  final String snack2Description;
  final int snack2Calories;
  final String dinnerDescription;
  final int dinnerCalories;
  const NutritionDayReport(
      {Key? key,
      required this.breakfastDescription,
      required this.breakfastCalories,
      required this.snack1Description,
      required this.snack1Calories,
      required this.lunchDescription,
      required this.lunchCalories,
      required this.snack2Description,
      required this.snack2Calories,
      required this.dinnerDescription,
      required this.dinnerCalories})
      : super(key: key);

  @override
  State<NutritionDayReport> createState() => _NutritionDayReportState();
}

class _NutritionDayReportState extends State<NutritionDayReport> {
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.035),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setSp(20),
              color: const Color(0XFF1F1E1C),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.078,
                MediaQuery.of(context).size.height * 0.028,
                0.0,
                MediaQuery.of(context).size.height * 0.018),
            child: Text(
              '${now.day} $month, ${now.year}',
              style: TextStyle(
                color: const Color(0XFF1F1E1C),
                fontSize: ScreenUtil().setSp(16.5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.width * 0.1,
                0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.002,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildMealRow(
                    context,
                    'Kahvaltı',
                    'assets/images/breakfast.svg',
                    widget.breakfastDescription,
                    widget.breakfastCalories,
                  ),
                  buildDivider(context),
                  buildMealRow(
                    context,
                    'Ara Öğün',
                    'assets/images/coffee.svg',
                    widget.snack1Description,
                    widget.snack1Calories,
                  ),
                  buildDivider(context),
                  buildMealRow(
                    context,
                    'Öğle Yemeği',
                    'assets/images/lunch.svg',
                    widget.lunchDescription,
                    widget.lunchCalories,
                  ),
                  buildDivider(context),
                  buildMealRow(
                    context,
                    'Ara Öğün',
                    'assets/images/drink.svg',
                    widget.snack2Description,
                    widget.snack2Calories,
                  ),
                  buildDivider(context),
                  buildMealRow(
                    context,
                    'Akşam Yemeği',
                    'assets/images/dinner.svg',
                    widget.dinnerDescription,
                    widget.dinnerCalories,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMealRow(BuildContext context, String mealName, String assetPath,
      String? description, int? calorie) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  0.0,
                  MediaQuery.of(context).size.height * 0.04,
                  MediaQuery.of(context).size.width * 0.08,
                  0.0),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.036),
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.width * 0.24,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: Theme.of(context).disabledColor, width: 1.5)),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(assetPath)),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.08),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.036),
              width: MediaQuery.of(context).size.width * 0.36,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                children: [
                  Icon(
                    BootstrapIcons.fire,
                    color: const Color(0XFF5E5F54).withOpacity(0.4),
                    size: ScreenUtil().setSp(26.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.036),
                    child: Text(
                      '${calorie ?? 0} kcal',
                      style: TextStyle(
                        color: const Color(0XFFBF0603),
                        fontSize: ScreenUtil().setSp(10.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.018,
                  MediaQuery.of(context).size.height * 0.024,
                  0.0,
                  MediaQuery.of(context).size.height * 0.003),
              child: Text(
                mealName,
                style: TextStyle(
                  color: const Color(0XFF1F1E1C),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(11.5),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: description == ''
                      ? Text(
                          'Eklenen ara öğün bilginiz yoktur..',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(11),
                          ),
                        )
                      : Text(
                          description.toString(),
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontSize: ScreenUtil().setSp(11),
                            fontWeight: FontWeight.w500,
                          ),
                        )),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDivider(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.1,
          MediaQuery.of(context).size.height * 0.02,
          MediaQuery.of(context).size.width * 0.1,
          0.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.002,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }
}
