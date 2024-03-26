import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

class SeventhFrame extends StatefulWidget {
  final Function(int) moveToPage;
  int selectedGender;

  SeventhFrame({Key? key, required this.moveToPage, required this.selectedGender}) : super(key: key);

  @override
  _SeventhFrameState createState() => _SeventhFrameState();
}

class _SeventhFrameState extends State<SeventhFrame> {
  final _getStorage = GetStorage();

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
              'Cinsiyetiniz ne?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0XFF5E5F54),
                fontSize: ScreenUtil().setSp(13.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                0.0,
                MediaQuery.of(context).size.height * 0.02,
                0.0,
                MediaQuery.of(context).size.height * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  width: MediaQuery.of(context).size.width * 0.24,
                  height: MediaQuery.of(context).size.width * 0.24,
                  decoration: BoxDecoration(
                      color: widget.selectedGender == 1
                          ? const Color(0XFFEE0475)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: widget.selectedGender == 1
                              ? const Color(0XFFEE0475)
                              : Theme.of(context).disabledColor.withOpacity(0.4),
                          width: 1.5)),
                  child: Material(
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: MaterialButton(
                      elevation: 0.0,
                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/images/woman.svg',
                            color: widget.selectedGender == 1
                                ? const Color(0XFFEAEAEA)
                                : Theme.of(context).disabledColor.withOpacity(0.4),
                          )),
                      onPressed: () {
                        setState(() {
                          widget.selectedGender = 1;
                          _getStorage.write('genderIndex', 1);
                          _getStorage.write('gender', 'female');
                          print('Gender: ' + _getStorage.read('genderIndex').toString() + _getStorage.read('gender').toString() );
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  width: MediaQuery.of(context).size.width * 0.24,
                  height: MediaQuery.of(context).size.width * 0.24,
                  decoration: BoxDecoration(
                      color: widget.selectedGender == 2
                          ? const Color(0XFF08C5FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: widget.selectedGender == 2
                              ? const Color(0XFF08C5FF)
                              : Theme.of(context).disabledColor.withOpacity(0.4),
                          width: 1.5)),
                  child: Material(
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: MaterialButton(
                      elevation: 0.0,
                      minWidth: MediaQuery.of(context).size.width * 0.7,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/images/man.svg',
                            color: widget.selectedGender == 2
                                ? const Color(0XFFEAEAEA)
                                : Theme.of(context).disabledColor.withOpacity(0.4),
                          )),
                      onPressed: () {
                        setState(() {
                          widget.selectedGender = 2;
                          _getStorage.write('genderIndex', 2);
                          _getStorage.write('gender', 'male');
                          print('Gender: ' + _getStorage.read('genderIndex').toString() + _getStorage.read('gender').toString() );
                        });
                      },
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
                if (widget.selectedGender != 0) {
                  widget.moveToPage(7);
                }
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
}
