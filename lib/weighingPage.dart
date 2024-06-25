import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class WeighingPage extends StatefulWidget {
  const WeighingPage({super.key});

  @override
  State<WeighingPage> createState() => _WeighingPageState();
}

class _WeighingPageState extends State<WeighingPage> {
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController weightToLoseController = TextEditingController();
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());
  String currentWeight = '0';
  String weightToLose = '0';

  @override
  void initState() {
    super.initState();
    fetchCurrentWeight();
  }

  Future<void> fetchCurrentWeight() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentReference weightDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email);

      DocumentSnapshot docSnapshot = await weightDoc.get();
      if (docSnapshot.exists) {
        setState(() {
          currentWeight = docSnapshot.get('weight').toString();
          weightToLose = docSnapshot.get('weightToLose').toString();
        });
      } else {
        print('Belge bulunamadı.');
      }
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.188),
                      child: SvgPicture.asset(
                        'assets/images/weighing.svg',
                        width: MediaQuery.of(context).size.width * 0.64,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            MediaQuery.of(context).size.height * 0.068,
                            0.0,
                            MediaQuery.of(context).size.height * 0.08),
                      
                      child: Text(
                          currentWeight,
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontSize: ScreenUtil().setSp(13.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0006),
                  child: Text(
                    'Hedefinize $weightToLose kg kaldı',
                    style: TextStyle(
                      color: const Color(0XFF1F1E1C),
                            fontSize: ScreenUtil().setSp(11.5),
                            fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
            margin: EdgeInsets.fromLTRB(
                0.0,
                MediaQuery.of(context).size.height * 0.128,
                0.0,
                MediaQuery.of(context).size.height * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_people_rounded,
                  color: const Color(0XFF5E5F54).withOpacity(0.4),
                  size: ScreenUtil().setSp(42.0),
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
                        'Güncel Kilonuz',
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
                          controller: currentWeightController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursorColor: const Color(0XFFBF0603),
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Güncel kilonuzu buraya girin...',
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
                0.0,
                MediaQuery.of(context).size.height * 0.0,
                0.0,
                MediaQuery.of(context).size.height * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.018,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.003),
                      child: Text(
                        'Vermek İstediğiniz Kilo',
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.003),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: weightToLoseController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursorColor: const Color(0XFFBF0603),
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Vermek istediğiniz kiloyu buraya girin...',
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.048,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
  addCurrentWeight(currentWeightController.text.trim(), weightToLoseController.text.trim()).then((_) {
    setState(() {
      fetchCurrentWeight();
    });
  });
});

              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0XFFBF0603)),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => const Color(0XFFA40502)),
              ),
              child: const Text('Güncelle'),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Future<void> addCurrentWeight(currentWeight, weightToLose) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentReference weightDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email);
      await weightDoc.update({'weight': currentWeight});
      await weightDoc.update({'weightToLose': weightToLose});
      setState(() {
        currentWeight = currentWeight;
        weightToLose = weightToLose;
      });
    }
  }
}
