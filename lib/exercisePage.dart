import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final _scrollController = ScrollController();
  DateTime now = DateTime.now();
  String month = DateFormat('MMMM', 'tr_TR')
      .format(DateTime.now()); // 'tr_TR' ile Türkçe ay ismi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        vertical: MediaQuery.of(context).size.height * 0.008
                      ),
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
                            '0 kcal',
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
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}