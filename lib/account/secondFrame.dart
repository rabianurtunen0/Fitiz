import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class SecondFrame extends StatefulWidget {
  final Function(int) moveToPage;
  int selectedTarget;

  SecondFrame(
      {Key? key, required this.moveToPage, required this.selectedTarget})
      : super(key: key);

  @override
  _SecondFrameState createState() => _SecondFrameState();
}

class _SecondFrameState extends State<SecondFrame> {
  final _getStorage = GetStorage();
  List targetList = ['Kilo almak', 'Hedef kilomu korumak', 'Kilo vermek'];

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
              'Hedefiniz ne?',
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
            height: MediaQuery.of(context).size.height * 0.216,
            child: ListView.builder(
                itemCount: targetList.length,
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
                        color: widget.selectedTarget == index
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            targetList[index],
                            style: TextStyle(
                              color: widget.selectedTarget == index
                                  ? Colors.white
                                  : const Color(0XFF1F1E1C),
                              fontSize: ScreenUtil().setSp(11.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.selectedTarget = index;
                            _getStorage.write('targetIndex', index);
                            print('İndex of target list: ' +
                                _getStorage.read('targetIndex').toString());
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
                if (widget.selectedTarget != 3) {
                  widget.moveToPage(2);
                }
              },
              color: Theme.of(context).disabledColor.withOpacity(0.4),
              shape: const CircleBorder(),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Theme.of(context).disabledColor.withOpacity(0.5),
              splashColor: Theme.of(context).disabledColor.withOpacity(0.5),
              child: Icon(BootstrapIcons.arrow_right,
                  color: Colors.white, size: ScreenUtil().setSp(16)),
            ),
          ),
        ],
      ),
    );
  }
}
