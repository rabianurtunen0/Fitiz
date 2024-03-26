import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FirstFrame extends StatefulWidget {
  final Function(int) moveToPage;

  const FirstFrame({Key? key, required this.moveToPage}) : super(key: key);

  @override
  _FirstFrameState createState() => _FirstFrameState();
}

class _FirstFrameState extends State<FirstFrame> {
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
              'Profil Ayarlama',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0XFF5E5F54),
                fontSize: ScreenUtil().setSp(13.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SvgPicture.asset('assets/images/profile_setting.svg'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.02,
                MediaQuery.of(context).size.height * 0.01,
                MediaQuery.of(context).size.width * 0.02,
                MediaQuery.of(context).size.height * 0.04),
            child: Text(
              "Başlangıçta, sizin için özel olarak 'Günlük Kalori Değerinizi' hesaplayacağız. Bu, beslenme hedefinizden, aktivite seviyenizden, yaşınızdan, boyunuzdan ve size özgü diğer özellikler ile hesaplanır.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            child: MaterialButton(
              onPressed: () {
                widget.moveToPage(1);
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
