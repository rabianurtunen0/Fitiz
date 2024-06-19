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

class AddMeal extends StatefulWidget {
  final int mealIndex;
  final String description;
  final int calorie;
  const AddMeal(
      {Key? key,
      required this.mealIndex,
      required this.description,
      required this.calorie})
      : super(key: key);

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {

  late TextEditingController mealDescriptionController;
  late TextEditingController calorieController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    mealDescriptionController = TextEditingController(
        text: widget.description.isNotEmpty ? widget.description : null);
    calorieController = TextEditingController(
        text: widget.calorie != 0 ? widget.calorie.toString() : null);
  }

  @override
  void dispose() {
    mealDescriptionController.dispose();
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
                  child: widget.mealIndex == 1
                      ? SvgPicture.asset('assets/images/breakfast.svg')
                      : widget.mealIndex == 2
                          ? SvgPicture.asset('assets/images/coffee.svg')
                          : widget.mealIndex == 3
                              ? SvgPicture.asset('assets/images/lunch.svg')
                              : widget.mealIndex == 4
                                  ? SvgPicture.asset('assets/images/drink.svg')
                                  : widget.mealIndex == 5
                                      ? SvgPicture.asset(
                                          'assets/images/dinner.svg')
                                      : null),
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
                  widget.mealIndex == 1
                      ? 'Kahvaltı'
                      : widget.mealIndex == 2
                          ? 'Ara Öğün'
                          : widget.mealIndex == 3
                              ? 'Öğle Yemeği'
                              : widget.mealIndex == 4
                                  ? 'Ara Öğün'
                                  : widget.mealIndex == 5
                                      ? 'Akşam Yemeği'
                                      : '',
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
                    controller: mealDescriptionController,
                    cursorColor: const Color(0XFFB840CD),
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Yemek açıklamasını buraya girin...',
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
                        'Alınan Toplam Kalori Miktarı',
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
                addMeal(widget.mealIndex);
              },
              child: const Text('Ekle'),
            ),
          ),
        ],
      ),
    );
  }

  void addMeal(int mealIndex) async {
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
    String mealDescription = mealDescriptionController.text.trim();
    String calorie = calorieController.text.trim();
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      DocumentReference mealDoc = _firestore
          .collection('Users')
          .doc(email)
          .collection('Nutrition')
          .doc(todayDate);

      mealIndex == 1
          ? await mealDoc
              .collection('Breakfast')
              .doc(mealIndex.toString())
              .set({
              'description': mealDescription,
              'calorie': int.parse(calorie),
            })
          : mealIndex == 2
              ? await mealDoc
                  .collection('Snack1')
                  .doc(mealIndex.toString())
                  .set({
                  'description': mealDescription,
                  'calorie': int.parse(calorie),
                })
              : mealIndex == 3
                  ? await mealDoc
                      .collection('Lunch')
                      .doc(mealIndex.toString())
                      .set({
                      'description': mealDescription,
                      'calorie': int.parse(calorie),
                    })
                  : mealIndex == 4
                      ? await mealDoc
                          .collection('Snack2')
                          .doc(mealIndex.toString())
                          .set({
                          'description': mealDescription,
                          'calorie': int.parse(calorie),
                        })
                      : mealIndex == 5
                          ? await mealDoc
                              .collection('Dinner')
                              .doc(mealIndex.toString())
                              .set({
                              'description': mealDescription,
                              'calorie': int.parse(calorie),
                            })
                          : null;

      Fluttertoast.showToast(
        msg: "Öğün başarıyla eklendi!",
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
