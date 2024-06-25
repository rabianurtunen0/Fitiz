import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final TextEditingController _controller = TextEditingController();
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR').format(DateTime.now());
  int totalWater = 0;

  @override
  void initState() {
    super.initState();
    fetchTotalWater();
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
          Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset(
                'assets/images/circle_water.json',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Text('$totalWater ml',
                    style: TextStyle(
                      color: const Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16.5),
                    )),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.0,
                MediaQuery.of(context).size.height * 0.072,
                0.0,
                MediaQuery.of(context).size.height * 0.018),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  BootstrapIcons.droplet_fill,
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
                        'İçilen Su Miktarı (ml)',
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
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursorColor: const Color(0XFF4CC9F0),
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'İçilen su miktarını buraya girin...',
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
                  addTotalWater(_controller.text.trim());
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0XFF4CC9F0)),
                overlayColor: MaterialStateProperty.resolveWith(
                    (states) => const Color(0XFF22BEED)),
              ),
              child: const Text('Güncelle'),
            ),
          ),
        ],
      ),
    );
  }

  void addTotalWater(totalWater) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      DocumentReference waterDoc = FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .collection('Water')
          .doc(todayDate);
      await waterDoc.set({'totalWater': totalWater});
      setState(() {
        this.totalWater = int.parse(totalWater);
      });
    }
  }
}
