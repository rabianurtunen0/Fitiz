import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/historicalWeighingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class WeighingPage extends StatefulWidget {
  const WeighingPage({super.key});

  @override
  State<WeighingPage> createState() => _WeighingPageState();
}

class _WeighingPageState extends State<WeighingPage> {
  final _getStorage = GetStorage();
  late final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentWeight = _getStorage.read('currentWeight');
    if (currentWeight != null) {
      _controller.text = currentWeight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/weighing.svg',
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.01,
                            0.0,
                            0.0,
                            MediaQuery.of(context).size.height * 0.22),
                        child: Text(
                          '62',
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontSize: ScreenUtil().setSp(12.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02),
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                                color: Color(0XFFBF0603), width: 1.5)),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02),
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            cursorColor: const Color(0XFF1F1E1C),
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontSize: ScreenUtil().setSp(12.5),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(
                                color: const Color(0XFF1F1E1C).withOpacity(0.5),
                                fontSize: ScreenUtil().setSp(12.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(0XFFBF0603),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            'kg',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(12.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.12,
              child: MaterialButton(
                onPressed: () {},
                color: Theme.of(context).disabledColor.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0.0,
                highlightElevation: 0.0,
                highlightColor:
                    Theme.of(context).disabledColor.withOpacity(0.5),
                splashColor: Theme.of(context).disabledColor.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Geçmiş Kilo Verileriniz',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12.5),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Icon(
                      BootstrapIcons.arrow_right,
                      color: Colors.white,
                      size: ScreenUtil().setSp(16),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
