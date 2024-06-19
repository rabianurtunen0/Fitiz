import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';


class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.1, 
          MediaQuery.of(context).size.height * 0.15, 
          MediaQuery.of(context).size.width * 0.1, 
          MediaQuery.of(context).size.height * 0.05),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.005,
              ),
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.048,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'y',
                    style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(11)),
                  ),
                  Text(
                    'x',
                    style: TextStyle(
                        color: const Color(0XFF131C24),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(11)),
                  ),
                ],
              ),
            ),
            Lottie.asset(
              'assets/images/circle_water.json',
                      ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/bootle.svg',
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                      ],
                    )),
                Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
