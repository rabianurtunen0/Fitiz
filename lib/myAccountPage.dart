import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {

  List activityLevel = [
    'Hareketsiz',
    'Düşük Düzeyde Hareketli',
    'Orta Düzeyde Hareketli',
    'Yüksek Düzeyde Hareketli',
    'Çok Yüksek Düzeyde Hareketli'
  ];
  List activityLevelDescription = [
    'Hareket etmiyorum veya çok az hareket ediyorum',
    'Haftada 1-3 gün egzersiz yapıyorum',
    'Haftada 3-5 gün egzersiz yapıyorum',
    'Haftada 6-7 gün egzersiz yapıyorum',
    'Profesyonel sporcu, atlet seviyesi'
  ];

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
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: MediaQuery.of(context).size.height * 0.03,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.036),
            width: MediaQuery.of(context).size.width * 0.24,
            height: MediaQuery.of(context).size.width * 0.24,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: true == true 
                        ? const Color(0XFFEE0475)
                        : const Color(0XFF08C5FF),
                    width: 1.5)),
            child: Align(
                alignment: Alignment.centerLeft,
                child: true == true
                    ? SvgPicture.asset('assets/images/woman.svg',
                        color: const Color(0XFFEE0475))
                    : SvgPicture.asset('assets/images/man.svg',
                        color: const Color(0XFF08C5FF))),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.018,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.003),
                      child: Text(
                        'Yaş',
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '0',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.068,
                          0.0,
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.003),
                      child: Text(
                        'Kilo (kg)',
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
                          MediaQuery.of(context).size.width * 0.05,
                          0.0),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '0',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.018,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.003),
                      child: Text(
                        'Boy (cm)',
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.048,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '0',
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.018,
                    0.0,
                    0.0,
                    MediaQuery.of(context).size.height * 0.003),
                child: Text(
                  'Hareket Düzeyi',
                  style: TextStyle(
                    color: const Color(0XFF1F1E1C),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(10.5),
                  ),
                ),
              ),
              Container(
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
                  child: Text(
                    activityLevel[0],
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
                vertical: MediaQuery.of(context).size.height * 0.045),
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
                        'Günlük Kalori Miktarı',
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
                        child: Text(
                          '${0} kcal',
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
          
        ],
      ),
    );
  }
}