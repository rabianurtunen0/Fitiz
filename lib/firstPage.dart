import 'package:fitiz/account/profileSettingPage.dart';
import 'package:fitiz/account/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              'assets/images/first_page_image.svg',
              width: MediaQuery.of(context).size.width * 0.76,
            ),
          Container(
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.16,
              MediaQuery.of(context).size.height * 0.1,
              MediaQuery.of(context).size.width * 0.16,
              MediaQuery.of(context).size.height * 0.01),
            child: Text(
              'Sadece Bir Adım Ötede Sağlıklı Yaşamın Kapıları Sizi Bekliyor!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0XFF5E5F54),
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w700,
                
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.06,
              0.0,
              MediaQuery.of(context).size.width * 0.06,
              MediaQuery.of(context).size.height * 0.04),
            child: Text(
              'Beslenme, egzersiz, su ve kilo takibi yapabilir, ayrıca kamera ile yiyeceklerin kalorilerini de kolayca öğrenebilirsiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: ScreenUtil().setSp(11),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.048,
            child: ElevatedButton(
              onPressed: () {
                Get.to(const ProfileSettingPage());
              },
              child: const Text('Başla'),
            ),
          ),
          
        ],
      ),
    );
  }
}