import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class AddExercise extends StatefulWidget {
  final exerciseIndex;
  final String description;
  final int calorie;
  const AddExercise(
      {Key? key,
      required this.exerciseIndex,
      required this.description,
      required this.calorie})
      : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {

  late TextEditingController exerciseDescriptionController;
  late TextEditingController calorieController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    exerciseDescriptionController = TextEditingController(
        text: widget.description.isNotEmpty ? widget.description : null);
    calorieController = TextEditingController(
        text: widget.calorie != 0 ? widget.calorie.toString() : null);
  }

  @override
  void dispose() {
    exerciseDescriptionController.dispose();
    calorieController.dispose();
    super.dispose();
  }

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04),
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
                  child: SvgPicture.asset('assets/images/exercisePeoples.svg'),
                ),
            ),
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
                  'Egzersiz',
                  style: TextStyle(
                    color: const Color(0XFF1F1E1C),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(11.5),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.348,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: exerciseDescriptionController,
                    cursorColor: const Color(0XFFB840CD),
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Egzersiz açıklamasını buraya girin...',
                      hintStyle: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(11.5),
                      ),
                      border: InputBorder.none,
                    ),
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
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  BootstrapIcons.fire,
                  color: const Color(0XFF5E5F54).withOpacity(0.4),
                  size: ScreenUtil().setSp(52.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.068,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.003),
                      child: Text(
                        'Harcanan Toplam Kalori Miktarı',
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.003),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: calorieController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursorColor: const Color(0XFFB840CD),
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Kalori miktarını buraya girin...',
                            hintStyle: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: const Color(0XFFBF0603),
                            fontSize: ScreenUtil().setSp(11.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.048,
            child: ElevatedButton(
              onPressed: () {
                addExercise(widget.exerciseIndex);
              },
              child: const Text('Ekle'),
            ),
          ),
        ],
      ),
    );
  }

  void addExercise(int exerciseIndex) async {
    User? user = _auth.currentUser;

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
    String exerciseDescription = exerciseDescriptionController.text.trim();
    String calorie = calorieController.text.trim();
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      DocumentReference mealDoc = _firestore
          .collection('Users')
          .doc(email)
          .collection('Exercise')
          .doc(todayDate);

      await mealDoc
              .collection('Exercise$exerciseIndex')
              .doc(exerciseIndex.toString())
              .set({
              'description': exerciseDescription,
              'calorie': int.parse(calorie),
            });

      Fluttertoast.showToast(
        msg: "Egzersiz başarıyla eklendi!",
        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
      );

      Get.back();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
      );
    }
  }

}