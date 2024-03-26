import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EighthFrame extends StatefulWidget {
  final Function(int) moveToPage;

  EighthFrame({Key? key, required this.moveToPage}) : super(key: key);

  @override
  _EighthFrameState createState() => _EighthFrameState();
}

class _EighthFrameState extends State<EighthFrame> {
  final _getStorage = GetStorage();
  DateTime minimumDate = DateTime(
      DateTime.now().year - 200, DateTime.now().month, DateTime.now().day);
  late DateTime newDateTime;
  late DateTime birthDate;

  Future<void> getBirthDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('birthDate');
    if (dateString != null && dateString.isNotEmpty) {
      setState(() {
        birthDate = DateTime.parse(dateString);
      });
    } else {
      setState(() {
        birthDate = DateTime.now();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBirthDate();
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
          Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.04),
            child: Text(
              'Doğum tarihiniz ne?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0XFF5E5F54),
                fontSize: ScreenUtil().setSp(13.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.12,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.width * 0.12,
                MediaQuery.of(context).size.height * 0.06),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: const Color(0XFF1F1E1C),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(11.5),
                    ),
                  )),
                  child: CupertinoDatePicker(
                    initialDateTime: birthDate,
                    onDateTimeChanged: (DateTime newDateTime) {
                      newDateTime = newDateTime;
                      setBirthDate(newDateTime);                      
                    },
                    minimumDate: minimumDate,
                    maximumDate: DateTime.now(),
                    minuteInterval: 1,
                    itemExtent: MediaQuery.of(context).size.height * 0.05,
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.dmy,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.66,
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.022),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.fromBorderSide(
                        BorderSide(
                          width: 1.5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            child: MaterialButton(
              onPressed: () {
                setBirthDate(birthDate);
                widget.moveToPage(8);
              },
              color: Theme.of(context).disabledColor.withOpacity(0.4),
              shape: const CircleBorder(),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Theme.of(context).disabledColor.withOpacity(0.5),
              splashColor: Theme.of(context).disabledColor.withOpacity(0.5),
              child: Icon(
                BootstrapIcons.arrow_right,
                color: Colors.white,
                size: ScreenUtil().setSp(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setBirthDate(DateTime newDateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('birthDate');
    prefs.setString('birthDate', newDateTime.toString());
    birthDate = DateTime.parse(prefs.getString('birthDate').toString());
    int age = DateTime.now().year - birthDate.year;
    if (DateTime.now().month < birthDate.month ||
        (DateTime.now().month == birthDate.month &&
            DateTime.now().day < birthDate.day)) {
      age--;
    }
    print('Doğum Tarihiniz: $birthDate');
    print('Yaşınız: $age');

    _getStorage.write('birthDate', birthDate);
    _getStorage.write('age', age);
    prefs.setInt('age', age);
   
    print(_getStorage.read('birthDate'));
    print(_getStorage.read('age'));
  }
}
