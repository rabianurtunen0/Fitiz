import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class SixthFrame extends StatefulWidget {
  final Function(int) moveToPage;
  int selectedActivity;

  SixthFrame(
      {Key? key, required this.moveToPage, required this.selectedActivity})
      : super(key: key);

  @override
  _SixthFrameState createState() => _SixthFrameState();
}

class _SixthFrameState extends State<SixthFrame> {
  final _getStorage = GetStorage();
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
                vertical: MediaQuery.of(context).size.height * 0.04),
            child: Text(
              'Etkinlik düzeyiniz ne?',
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
            height: MediaQuery.of(context).size.height * 0.36,
            child: ListView.builder(
                itemCount: activityLevel.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.006,
                        horizontal: MediaQuery.of(context).size.width * 0.06),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Material(
                      elevation: 0.0,
                      color: Colors.transparent,
                      child: MaterialButton(
                        elevation: 0.0,
                        minWidth: MediaQuery.of(context).size.width * 0.7,
                        color: widget.selectedActivity == index
                            ? Theme.of(context).primaryColor
                            : const Color(0XFFEAEAEA),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                activityLevel[index],
                                style: TextStyle(
                                  color: widget.selectedActivity == index
                                      ? Colors.white
                                      : const Color(0XFF1F1E1C),
                                  fontSize: ScreenUtil().setSp(11.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                activityLevelDescription[index],
                                style: TextStyle(
                                  color: widget.selectedActivity == index
                                      ? const Color(0XFFEAEAEA)
                                      : Theme.of(context).disabledColor,
                                  fontSize: ScreenUtil().setSp(8.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            widget.selectedActivity = index;
                            _getStorage.write('activityIndex', index);
                            print('İndex of activity list: ' +
                                _getStorage.read('activityIndex').toString());
                          });
                        },
                      ),
                    ),
                  );
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            child: MaterialButton(
              onPressed: () {
                if (widget.selectedActivity != 5) {
                  widget.moveToPage(6);
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
