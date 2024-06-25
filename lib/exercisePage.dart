import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/addExercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());

  List<String> exerciseDescriptions = [];
  List<int> exerciseCalories = [];
  int totalCalorie = 0;

  @override
  void initState() {
    super.initState();
    fetchExercises();
  }

  Future<void> fetchExercises() async {
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

    DocumentReference exerciseDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Exercise')
        .doc(todayDate);

    try {
      setState(() {
        exerciseDescriptions.clear();
        exerciseCalories.clear();
      });

      DocumentSnapshot docSnapshot = await exerciseDoc.get();
      if (docSnapshot.exists) {
        for (int i = 1;; i++) {
          String exerciseCollectionName = 'Exercise$i';
          CollectionReference exerciseCollection =
              exerciseDoc.collection(exerciseCollectionName);
          QuerySnapshot exerciseSnapshots = await exerciseCollection.get();

          if (exerciseSnapshots.docs.isEmpty) {
            break;
          }

          for (var exerciseDoc in exerciseSnapshots.docs) {
            if (exerciseDoc.exists) {
              Map<String, dynamic> data =
                  exerciseDoc.data() as Map<String, dynamic>;
              setState(() {
                exerciseDescriptions
                    .add(data['description'].replaceAll('\\n', '\n'));
                exerciseCalories.add(data['calorie']);
              });
              print("Description: ${data['description']}");
              print("Calories: ${data['calorie']}");
            }
          }
        }
      }

      print("Exercise Descriptions: $exerciseDescriptions");
      print("Exercise Calories: $exerciseCalories");

      if (exerciseCalories.isNotEmpty) {
        setState(() {
          totalCalorie = exerciseCalories.reduce((a, b) => a + b);
        });
      }

      print("Total Calorie: $totalCalorie");

      await exerciseDoc.set({'totalCalorie': totalCalorie});
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
                          'Harcanan Kalori Miktarı',
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(10.5),
                          ),
                        ),
                        Text(
                          '$totalCalorie kcal',
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
          exerciseDescriptions.length == 0
              ? Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child:
                          SvgPicture.asset('assets/images/exercisePeoples.svg'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.048,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddExercise(
                                    exerciseIndex: 1,
                                    description: '',
                                    calorie: 0,
                                  ))!
                              .then((_) {
                            setState(() {
                              fetchExercises();
                            });
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0XFFFF712C)),
                          overlayColor: MaterialStateProperty.resolveWith(
                              (states) => const Color(0XFFFF5703)),
                        ),
                        child: const Text('Egzersiz ekle'),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    for (int i = 0; i < exerciseDescriptions.length; i++)
                      buildExercise(
                        context,
                        i + 1,
                        exerciseDescriptions[i],
                        exerciseCalories[i],
                        () => setState(() {
                          fetchExercises();
                        }),
                      ),
                      Container(
            margin: EdgeInsets.fromLTRB(
                0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.088,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => AddExercise(
                          exerciseIndex: exerciseDescriptions.length + 1,
                          description: '',
                          calorie: 0,
                        ))!
                    .then((_) {
                  setState(() {
                    fetchExercises();
                  });
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0XFFFF712C)),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => const Color(0XFFFF5703)),
              ),
              child: Text('Başka bir tane daha egzersiz ekle'),
            ),
          ),
                  ],
                ),
          
        ],
      ),
    );
  }

  goAddExercise(int exerciseIndex, String description, int calorie) {
    Get.to(() => AddExercise(
              exerciseIndex: exerciseIndex,
              description: description,
              calorie: calorie,
            ))!
        .then((_) {
      setState(() {
        fetchExercises();
      });
    });
  }
}

Widget buildExercise(BuildContext context, int exerciseIndex,
    String description, int calorie, VoidCallback refresh) {
  return GestureDetector(
    onTap: () {
      Get.to(() => AddExercise(
                exerciseIndex: exerciseIndex,
                description: description,
                calorie: calorie,
              ))!
          .then((_) {
        refresh();
      });
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.1,
          MediaQuery.of(context).size.height * 0.02,
          MediaQuery.of(context).size.width * 0.1,
          0.0),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.088,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.036),
                    child: Icon(
                      BootstrapIcons.fire,
                      color: const Color(0XFF5E5F54).withOpacity(0.4),
                      size: ScreenUtil().setSp(32.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.036,
                        MediaQuery.of(context).size.height * 0.01,
                        0.0,
                        0.0),
                    child: Text(
                      '${calorie ?? 0}',
                      style: TextStyle(
                        color: const Color(0XFFBF0603),
                        fontSize: ScreenUtil().setSp(10.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.036),
                    child: Text(
                      'kcal',
                      style: TextStyle(
                        color: const Color(0XFFBF0603),
                        fontSize: ScreenUtil().setSp(10.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    description,
                    style: TextStyle(
                      color: const Color(0XFF1F1E1C),
                      fontSize: ScreenUtil().setSp(11.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              //goAddExercise;
            },
            height: MediaQuery.of(context).size.width * 0.1,
            color: const Color(0XFFFF5703).withOpacity(0.6),
            shape: const CircleBorder(),
            elevation: 0.0,
            highlightElevation: 0.0,
            highlightColor: const Color(0XFFFF5703).withOpacity(0.5),
            splashColor: const Color(0XFFFF5703).withOpacity(0.5),
            child: Icon(
              BootstrapIcons.check,
              color: Colors.white,
              size: ScreenUtil().setSp(24),
            ),
          ),
        ],
      ),
    ),
  );
}
