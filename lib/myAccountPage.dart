import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/addExercise.dart';
import 'package:fitiz/updateAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());
  GetStorage getStorage = GetStorage();
  int activityIndex = 0;
  int age = 0;
  DateTime birthDate = DateTime.now();
  String email = FirebaseAuth.instance.currentUser!.email.toString();
  String gender = '';
  int genderIndex = 0;
  String height = '';
  String nameAndSurname = '';
  int targetIndex = 0;
  String weight = '';
  String weightToLose = '';
  int nutritionCalorie = 0;
  int exerciseCalorie = 0; 
  int totalWater = 0;
  int calorie = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchCalorie();
    fetchTotalWater();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentReference doc =
          FirebaseFirestore.instance.collection('Users').doc(email);

      DocumentSnapshot docSnapshot = await doc.get();
      if (docSnapshot.exists) {
        setState(() {
          activityIndex = docSnapshot.get('activityIndex');
          age = docSnapshot.get('age');
          Timestamp timestamp = docSnapshot.get('birthDate');
          birthDate = timestamp.toDate();
          email = docSnapshot.get('email');
          gender = docSnapshot.get('gender');
          genderIndex = docSnapshot.get('genderIndex');
          height = docSnapshot.get('height');
          nameAndSurname = docSnapshot.get('nameAndSurname');
          targetIndex = docSnapshot.get('targetIndex');
          weight = docSnapshot.get('weight');
          weightToLose = docSnapshot.get('weightToLose');
          calorie = docSnapshot.get('calorie');
        });
        print(activityIndex);
        print(age);
        print(birthDate);
        print(email);
        print(gender);
        print(genderIndex);
        print(height);
        print(nameAndSurname);
        print(targetIndex);
        print(weight);
        print(weightToLose);
        print(calorie);
      } else {
        print('Belge bulunamadı.');
      }
    }
  }

  Future<void> fetchCalorie() async {
     User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference nutritionDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .collection('Nutrition')
          .doc(todayDate);
      DocumentReference exerciseDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .collection('Exercise')
          .doc(todayDate);

      DocumentSnapshot nutritionDocSnapshot = await nutritionDoc.get();
      DocumentSnapshot exerciseDocSnapshot = await exerciseDoc.get();

      if (nutritionDocSnapshot.exists) {
        setState(() {
          nutritionCalorie = int.parse(nutritionDocSnapshot.get('totalCalorie').toString());
        });
      } else {
        print('Belge bulunamadı.');
      }

      if (exerciseDocSnapshot.exists) {
        setState(() {
          exerciseCalorie = int.parse(exerciseDocSnapshot.get('totalCalorie').toString());
        });
      } else {
        print('Belge bulunamadı.');
      }
    }
  }

  Future<void> fetchTotalWater() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference waterDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .collection('Water')
          .doc(todayDate);

      DocumentSnapshot docSnapshot = await waterDoc.get();
      if (docSnapshot.exists) {
        setState(() {
          totalWater = int.parse(docSnapshot.get('totalWater').toString());
        });
      } else {
        print('Belge bulunamadı.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => UpdateAccount(
                      activityIndex: activityIndex,
                      age: age,
                      birthDate: birthDate,
                      email: email,
                      gender: gender,
                      genderIndex: genderIndex,
                      height: height,
                      nameAndSurname: nameAndSurname,
                      targetIndex: targetIndex,
                      weight: weight,
                      weightToLose: weightToLose,
                      calorie: calorie))!
                  .then((_) {
                setState(() {
                  fetchUserData();
                  fetchCalorie();
                  fetchTotalWater();
                });
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                0.0,
                MediaQuery.of(context).size.height * 0.16,
                0.0,
                MediaQuery.of(context).size.height * 0.03,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.16,
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
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.036,
                              0.0,
                              MediaQuery.of(context).size.width * 0.012,
                              0.0),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.036),
                          width: MediaQuery.of(context).size.width * 0.24,
                          height: MediaQuery.of(context).size.width * 0.24,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: gender == 'female'
                                  ? SvgPicture.asset('assets/images/woman.svg',
                                      color: const Color(0XFFB840CD))
                                  : SvgPicture.asset('assets/images/man.svg',
                                      color: const Color(0XFFB840CD))),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Text(
                              nameAndSurname,
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            Container(
                                child: Text(
                              email,
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C).withOpacity(0.6),
                                fontSize: ScreenUtil().setSp(9.5),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Icon(
                          BootstrapIcons.chevron_right,
                          color: const Color(0XFFB840CD),
                          size: ScreenUtil().setSp(16),
                        ))
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.46,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.048,
                      MediaQuery.of(context).size.height * 0.018,
                      0.0,
                      MediaQuery.of(context).size.height * 0.018),
                  child: Text(
                    'Gün Raporu (${now.day} $month, ${now.year})',
                    style: TextStyle(
                      color: const Color(0XFF1F1E1C),
                      fontSize: ScreenUtil().setSp(12.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.13,
                        lineWidth: 5.0,
                        percent: 1.0,
                        progressColor: Color(0XFF8DB600),
                        backgroundColor: Theme.of(context).cardColor,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/fork_spoon.svg',
                              color: const Color(0XFF8DB600),
                              width: ScreenUtil().setSp(17),
                              height: ScreenUtil().setSp(17),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Text(
                                '$nutritionCalorie kcal',
                                style: TextStyle(
                                  color: const Color(0XFF1F1E1C),
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.width * 0.13,
                        lineWidth: 5.0,
                        percent: 1.0,
                        progressColor: Color(0XFFFF712C),
                        backgroundColor: Theme.of(context).cardColor,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/exercise.svg',
                              color: const Color(0XFFFF712C),
                              width: ScreenUtil().setSp(17),
                              height: ScreenUtil().setSp(17),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Text(
                                '$exerciseCalorie kcal',
                                style: TextStyle(
                                  color: const Color(0XFF1F1E1C),
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.008),
                      child: Icon(
                        BootstrapIcons.droplet_fill,
                        color: const Color(0XFF4CC9F0),
                        size: ScreenUtil().setSp(42.0),
                      ),
                    ),
                    Text(
                      '$totalWater ml',
                      style: TextStyle(
                        color: const Color(0XFF1F1E1C),
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0.0,
                    MediaQuery.of(context).size.height * 0.048,
                    0.0,
                    MediaQuery.of(context).size.height * 0.028
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.001,
                  color: Theme.of(context).disabledColor
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.072,
                        0.0,
                        MediaQuery.of(context).size.width * 0.024,
                        0.0
                      ),
                      child: Icon(
                        BootstrapIcons.fire,
                        color: const Color(0XFF5E5F54).withOpacity(0.4),
                        size: ScreenUtil().setSp(39.0),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            'Günlük Kalori Miktarı',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            '${nutritionCalorie - exerciseCalorie}/$calorie kcal',
                            style: TextStyle(
                              color: const Color(0XFFBF0603),
                              fontSize: ScreenUtil().setSp(10.5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
              
                
            
            ),    
              ],
            ),
          ),
        ],
      ),
    );
  }
}
