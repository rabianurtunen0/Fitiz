import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/addMeal.dart';
import 'package:fitiz/calorieCalculationPage.dart';
import 'package:fitiz/nutritionDayReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());

  String breakfastDescription = '';
  int breakfastCalories = 0;
  String snack1Description = '';
  int snack1Calories = 0;
  String lunchDescription = '';
  int lunchCalories = 0;
  String snack2Description = '';
  int snack2Calories = 0;
  String dinnerDescription = '';
  int dinnerCalories = 0;

  @override
  void initState() {
    fetchMeals();
    super.initState();
  }

  Future<void> fetchMeals() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(
        msg: "Lütfen giriş yapın.",
        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
      );
      return;
    }

    String email = user.email!;
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    DocumentReference mealDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Nutrition')
        .doc(todayDate);

    try {
      DocumentSnapshot breakfastSnapshot =
          await mealDoc.collection('Breakfast').doc('1').get();
      DocumentSnapshot snack1Snapshot =
          await mealDoc.collection('Snack1').doc('2').get();
      DocumentSnapshot lunchSnapshot =
          await mealDoc.collection('Lunch').doc('3').get();
      DocumentSnapshot snack2Snapshot =
          await mealDoc.collection('Snack2').doc('4').get();
      DocumentSnapshot dinnerSnapshot =
          await mealDoc.collection('Dinner').doc('5').get();

      setState(() {
        if (breakfastSnapshot.exists) {
          breakfastDescription =
              breakfastSnapshot['description'].replaceAll('\\n', '\n');
          breakfastCalories = breakfastSnapshot['calorie'];
        } else {
          breakfastDescription = '';
          breakfastCalories = 0;
        }

        if (snack1Snapshot.exists) {
          snack1Description =
              snack1Snapshot['description'].replaceAll('\\n', '\n');
          snack1Calories = snack1Snapshot['calorie'];
        } else {
          snack1Description = '';
          snack1Calories = 0;
        }

        if (lunchSnapshot.exists) {
          lunchDescription =
              lunchSnapshot['description'].replaceAll('\\n', '\n');
          lunchCalories = lunchSnapshot['calorie'];
        } else {
          lunchDescription = '';
          lunchCalories = 0;
        }

        if (snack2Snapshot.exists) {
          snack2Description =
              snack2Snapshot['description'].replaceAll('\\n', '\n');
          snack2Calories = snack2Snapshot['calorie'];
        } else {
          snack2Description = '';
          snack2Calories = 0;
        }

        if (dinnerSnapshot.exists) {
          dinnerDescription =
              dinnerSnapshot['description'].replaceAll('\\n', '\n');
          dinnerCalories = dinnerSnapshot['calorie'];
        } else {
          dinnerDescription = '';
          dinnerCalories = 0;
        }
      });

      await mealDoc.set({
        'totalCalorie': breakfastCalories +
            snack1Calories +
            lunchCalories +
            snack2Calories +
            dinnerCalories
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
      );
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.078,
                MediaQuery.of(context).size.height * 0.148,
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.036),
              width: MediaQuery.of(context).size.width * 0.68,
              height: MediaQuery.of(context).size.width * 0.12,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12.0), right: Radius.zero),
              ),
              child: Row(
                children: [
                  Icon(
                    BootstrapIcons.fire,
                    color: const Color(0XFF5E5F54).withOpacity(0.4),
                    size: ScreenUtil().setSp(26.0),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.036,
                        vertical: MediaQuery.of(context).size.height * 0.008),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alınan Kalori Miktarı',
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(10.5),
                          ),
                        ),
                        Text(
                          '${breakfastCalories + snack1Calories + lunchCalories + snack2Calories + dinnerCalories} kcal',
                          style: TextStyle(
                            color: const Color(0XFFBF0603),
                            fontSize: ScreenUtil().setSp(10.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AddMeal(
                        mealIndex: 1,
                        description: breakfastDescription,
                        calorie: breakfastCalories,
                      ))!
                  .then((_) {
                setState(() {
                  fetchMeals();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.1,
                  0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.088,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: SvgPicture.asset(
                          'assets/images/breakfast.svg',
                          width: MediaQuery.of(context).size.height * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kahvaltı',
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$breakfastCalories kcal',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: ScreenUtil().setSp(8.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => AddMeal(
                                mealIndex: 1,
                                description: breakfastDescription,
                                calorie: breakfastCalories,
                              ))!
                          .then((_) {
                        setState(() {
                          fetchMeals();
                        });
                      });
                    },
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: breakfastCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.3)
                        : const Color(0XFF8DB600).withOpacity(0.6),
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    highlightColor: breakfastCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    splashColor: breakfastCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    child: Icon(
                      breakfastCalories == 0
                          ? BootstrapIcons.plus
                          : BootstrapIcons.check,
                      color: Colors.white,
                      size: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AddMeal(
                        mealIndex: 2,
                        description: snack1Description,
                        calorie: snack1Calories,
                      ))!
                  .then((_) {
                setState(() {
                  fetchMeals();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.1,
                  0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.088,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: SvgPicture.asset(
                          'assets/images/coffee.svg',
                          width: MediaQuery.of(context).size.height * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ara Öğün',
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$snack1Calories kcal',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: ScreenUtil().setSp(8.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => AddMeal(
                                mealIndex: 2,
                                description: snack1Description,
                                calorie: snack1Calories,
                              ))!
                          .then((_) {
                        setState(() {
                          fetchMeals();
                        });
                      });
                    },
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: snack1Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.3)
                        : const Color(0XFF8DB600).withOpacity(0.6),
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    highlightColor: snack1Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    splashColor: snack1Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    child: Icon(
                      snack1Calories == 0
                          ? BootstrapIcons.plus
                          : BootstrapIcons.check,
                      color: Colors.white,
                      size: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AddMeal(
                        mealIndex: 3,
                        description: lunchDescription,
                        calorie: lunchCalories,
                      ))!
                  .then((_) {
                setState(() {
                  fetchMeals();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.1,
                  0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.088,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: SvgPicture.asset(
                          'assets/images/lunch.svg',
                          width: MediaQuery.of(context).size.height * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Öğle Yemeği',
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$lunchCalories kcal',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: ScreenUtil().setSp(8.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => AddMeal(
                              mealIndex: 3,
                              description: lunchDescription,
                              calorie: lunchCalories))!
                          .then((_) {
                        setState(() {
                          fetchMeals();
                        });
                      });
                    },
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: lunchCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.3)
                        : const Color(0XFF8DB600).withOpacity(0.6),
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    highlightColor: lunchCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    splashColor: lunchCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    child: Icon(
                      lunchCalories == 0
                          ? BootstrapIcons.plus
                          : BootstrapIcons.check,
                      color: Colors.white,
                      size: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AddMeal(
                        mealIndex: 4,
                        description: snack2Description,
                        calorie: snack2Calories,
                      ))!
                  .then((_) {
                setState(() {
                  fetchMeals();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.1,
                  0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.088,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: SvgPicture.asset(
                          'assets/images/drink.svg',
                          width: MediaQuery.of(context).size.height * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Ara Öğün',
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$snack2Calories kcal',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: ScreenUtil().setSp(8.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => AddMeal(
                                mealIndex: 4,
                                description: snack2Description,
                                calorie: snack2Calories,
                              ))!
                          .then((_) {
                        setState(() {
                          fetchMeals();
                        });
                      });
                    },
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: snack2Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.3)
                        : const Color(0XFF8DB600).withOpacity(0.6),
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    highlightColor: snack2Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    splashColor: snack2Calories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    child: Icon(
                      snack2Calories == 0
                          ? BootstrapIcons.plus
                          : BootstrapIcons.check,
                      color: Colors.white,
                      size: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => AddMeal(
                        mealIndex: 5,
                        description: dinnerDescription,
                        calorie: dinnerCalories,
                      ))!
                  .then((_) {
                setState(() {
                  fetchMeals();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.1,
                  0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.088,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: SvgPicture.asset(
                          'assets/images/dinner.svg',
                          width: MediaQuery.of(context).size.height * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Akşam Yemeği',
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$dinnerCalories kcal',
                              style: TextStyle(
                                color: Theme.of(context).disabledColor,
                                fontSize: ScreenUtil().setSp(8.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.to(() => AddMeal(
                                mealIndex: 5,
                                description: dinnerDescription,
                                calorie: dinnerCalories,
                              ))!
                          .then((_) {
                        setState(() {
                          fetchMeals();
                        });
                      });
                    },
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: dinnerCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.3)
                        : const Color(0XFF8DB600).withOpacity(0.6),
                    shape: const CircleBorder(),
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    highlightColor: dinnerCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    splashColor: dinnerCalories == 0
                        ? Color(0XFF5E5F54).withOpacity(0.2)
                        : const Color(0XFF799D00).withOpacity(0.5),
                    child: Icon(
                      dinnerCalories == 0
                          ? BootstrapIcons.plus
                          : BootstrapIcons.check,
                      color: Colors.white,
                      size: ScreenUtil().setSp(24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.088,
            child: ElevatedButton(
              onPressed: () {
                Get.to(NutritionDayReport(
                  breakfastDescription: breakfastDescription,
                  breakfastCalories: breakfastCalories,
                  snack1Description: snack1Description,
                  snack1Calories: snack1Calories,
                  lunchDescription: lunchDescription,
                  lunchCalories: lunchCalories,
                  snack2Description: snack2Description,
                  snack2Calories: snack2Calories,
                  dinnerDescription: dinnerDescription,
                  dinnerCalories: dinnerCalories,
                ));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0XFF8DB600)),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => const Color(0XFF799D00)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gün Raporu'),
                  Icon(
                    BootstrapIcons.arrow_right,
                    size: ScreenUtil().setSp(20.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
