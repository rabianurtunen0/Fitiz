import 'package:fitiz/account/eighthFrame.dart';
import 'package:fitiz/account/fifthFrame.dart';
import 'package:fitiz/account/firstFrame.dart';
import 'package:fitiz/account/fourthFrame.dart';
import 'package:fitiz/account/loginPage.dart';
import 'package:fitiz/account/ninthFrame.dart';
import 'package:fitiz/account/secondFrame.dart';
import 'package:fitiz/account/seventhFrame.dart';
import 'package:fitiz/account/sixthFrame.dart';
import 'package:fitiz/account/thirdFrame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  final _fromKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final _getStorage = GetStorage();
  var currentPage = 0;
  int weight = 0;
  int height = 0;
  int age = 0;
  String gender = 'female';
  int activityLevel = 0;
  double activityLevelValue = 1.2;
  double calorie = 0.0;

  @override
  void initState(){
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        leading: Container(
          alignment: Alignment.centerLeft,
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.035),
          child: IconButton(
            onPressed: () {
              setState(() {
                if(currentPage == 0) {
                  Get.back();
                } else {
                  _moveToPage(currentPage - 1);
                }
              });
            },
            icon: Icon(
              Icons.arrow_back,
              size: ScreenUtil().setSp(20),
              color: const Color(0XFF1F1E1C),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  0.0,
                  MediaQuery.of(context).size.height * 0.02,
                  0.0,
                  MediaQuery.of(context).size.height * 0.04),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 9,
                effect: SwapEffect(
                  activeDotColor: const Color(0XFF5E5F54),
                  dotColor: Theme.of(context).disabledColor.withOpacity(0.3),
                  dotHeight: 8,
                  dotWidth: MediaQuery.of(context).size.width * 0.044,
                  spacing: 16,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.72,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FirstFrame(
                    moveToPage: _moveToPage,
                  ),
                  SecondFrame(
                    moveToPage: _moveToPage,
                    selectedTarget: _getStorage.read('targetIndex') == null ? 3 : _getStorage.read('targetIndex'),
                  ),
                  ThirdFrame(
                    moveToPage: _moveToPage,
                  ),
                  FourthFrame(
                    moveToPage: _moveToPage,
                  ),
                  FifthFrame(
                    moveToPage: _moveToPage,
                  ),
                  SixthFrame(
                    moveToPage: _moveToPage,
                    selectedActivity: _getStorage.read('activityIndex') == null ? 5 : _getStorage.read('activityIndex'),
                  ),
                  SeventhFrame(
                    moveToPage: _moveToPage,
                    selectedGender: _getStorage.read('genderIndex') == null ? 0 : _getStorage.read('genderIndex'),
                  ),
                  EighthFrame(
                    moveToPage: _moveToPage,
                  ),
                  NinthFrame(
                    weight: weight,
                    height: height,
                    age: age,
                    gender: gender,
                    activityLevel: activityLevel,
                    calorie: calorie
                  )
                ],
              ),
            ),
            Visibility(
              visible: currentPage == 0,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Zaten bir hesabınız var mı?",
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(10.5),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(LoginPage(logOut: false));
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Text('Giriş Yap',
                          style: TextStyle(
                              color: const Color(0XFF5E5F54),
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(10.5),
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _moveToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    ); 
    calculateCalorie();
  }

  void calculateCalorie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    weight = int.tryParse(_getStorage.read('currentWeight'))!;
    print(weight);
    height = int.tryParse(_getStorage.read('height'))!;
    print(height);
    age = (prefs.getInt('age') == null ? 0 : prefs.getInt('age'))!;
    print(age);
    gender = _getStorage.read('gender');
    print(gender);
    activityLevel = _getStorage.read('activityIndex');
    print(activityLevel);

    double activityLevelValue = 0.0;
    if(activityLevel == 0) {
      activityLevelValue = 1.2;
    } else if(activityLevel == 1) {
      activityLevelValue = 1.375;
    } else if(activityLevel == 2) {
      activityLevelValue = 1.55;
    } else if(activityLevel == 3) {
      activityLevelValue = 1.725;
    } else if(activityLevel == 4) {
      activityLevelValue = 1.9;
    }

    if(gender == 'female') {
      double bmr = 66.5 + (13.75 * weight) + (5 * height) - (6.77 * age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');

    } else if(gender == 'male') {
      double bmr = 655.1 + (9.56 * weight) + (1.85 * height) - (4.67 * age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');

    } else {
      double bmr = 66.5 + (13.75 * weight) + (5 * height) - (6.77 * age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');
    }
  }

}
