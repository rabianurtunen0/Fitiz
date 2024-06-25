import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:fitiz/account/loginPage.dart';
import 'package:fitiz/exercisePage.dart';
import 'package:fitiz/myAccountPage.dart';
import 'package:fitiz/nutritionPage.dart';
import 'package:fitiz/waterPage.dart';
import 'package:fitiz/weighingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 1;
  late final _pageController = PageController(initialPage: selectedIndex);
  List<Widget> drawerPages = [
    const MyAccountPage(),
    const NutritionPage(),
    const ExercisePage(),
    const WaterPage(),
    const WeighingPage(),
  ];

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return Container( 
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.035),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset('assets/images/menu.svg',
                  width: ScreenUtil().setSp(16),
                  height: ScreenUtil().setSp(16),
                  color: const Color(0XFF1F1E1C)),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          );
        }),
      ), 
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width * 0.6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.zero,
            right: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.076,
                      MediaQuery.of(context).size.height * 0.096,
                      0.0,
                      MediaQuery.of(context).size.height * 0.036),
                  child: SvgPicture.asset(
                    'assets/images/fitiz_logo.svg',
                    height: MediaQuery.of(context).size.height * 0.051,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0.0,
                      MediaQuery.of(context).size.height * 0.0066, 0.0, 0.0),
                  decoration: selectedIndex == 0
                      ? BoxDecoration(
                          color: const Color(0XFFEFF0F1),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0XFFB840CD),
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(0);
                        selectedIndex = 0;
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              0.0),
                          child: Icon(
                            BootstrapIcons.person_fill,
                            color: const Color(0XFFB840CD),
                            size: ScreenUtil().setSp(17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.045,
                              0.0,
                              0.0,
                              0.0),
                          child: Text(
                            'Hesabım',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: const Color(0XFFB840CD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0.0,
                      MediaQuery.of(context).size.height * 0.0066, 0.0, 0.0),
                  decoration: selectedIndex == 1
                      ? BoxDecoration(
                          color: const Color(0XFFEFF0F1),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0XFF8DB600),
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(1);
                        selectedIndex = 1;
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              0.0),
                          child: SvgPicture.asset(
                            'assets/images/fork_spoon.svg',
                            color: const Color(0XFF8DB600),
                            width: ScreenUtil().setSp(17),
                            height: ScreenUtil().setSp(17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.045,
                              0.0,
                              0.0,
                              0.0),
                          child: Text(
                            'Beslenme',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: const Color(0XFF8DB600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0.0,
                      MediaQuery.of(context).size.height * 0.0066, 0.0, 0.0),
                  decoration: selectedIndex == 2
                      ? BoxDecoration(
                          color: const Color(0XFFEFF0F1),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0XFFFF712C),
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(2);
                        selectedIndex = 2;
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              0.0),
                          child: SvgPicture.asset(
                            'assets/images/exercise.svg',
                            color: const Color(0XFFFF712C),
                            width: ScreenUtil().setSp(17),
                            height: ScreenUtil().setSp(17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.045,
                              0.0,
                              0.0,
                              0.0),
                          child: Text(
                            'Egzersiz',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: const Color(0XFFFF712C),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0.0,
                      MediaQuery.of(context).size.height * 0.0066, 0.0, 0.0),
                  decoration: selectedIndex == 3
                      ? BoxDecoration(
                          color: const Color(0XFFEFF0F1),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0XFF4CC9F0),
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(3);
                        selectedIndex = 3;
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              0.0),
                          child: Icon(
                            BootstrapIcons.droplet_half,
                            color: const Color(0XFF4CC9F0),
                            size: ScreenUtil().setSp(17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.045,
                              0.0,
                              0.0,
                              0.0),
                          child: Text(
                            'Su ',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: const Color(0XFF4CC9F0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0.0,
                      MediaQuery.of(context).size.height * 0.0066, 0.0, 0.0),
                  decoration: selectedIndex == 4
                      ? BoxDecoration(
                          color: const Color(0XFFEFF0F1),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0XFFBF0603),
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        )
                      : BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width * 0.018,
                            ),
                          ),
                        ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _pageController.jumpToPage(4);
                        selectedIndex = 4;
                      });
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              0.0),
                          child: Icon(
                            Icons.monitor_weight,
                            color: const Color(0XFFBF0603),
                            size: ScreenUtil().setSp(17),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.045,
                              0.0,
                              0.0,
                              0.0),
                          child: Text(
                            'Kilo',
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(12),
                              color: const Color(0XFFBF0603),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  0.0,
                  MediaQuery.of(context).size.height * 0.022,
                  0.0,
                  MediaQuery.of(context).size.height * 0.055),
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            child: MaterialButton(
              onPressed: () {
                logOut();
              },
              color: Theme.of(context).disabledColor.withOpacity(0.4),
              shape: const CircleBorder(),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Theme.of(context).disabledColor.withOpacity(0.5),
              splashColor: Theme.of(context).disabledColor.withOpacity(0.5),
              child: Icon(Icons.logout,
                  color: Colors.white, size: ScreenUtil().setSp(16)),
            ),
          ),
            
          ],
        ),
      ),
      onDrawerChanged: (isOpened) {
        isOpened
            ? _scaffoldKey.currentState?.openDrawer()
            : _scaffoldKey.currentState?.closeDrawer();
      },
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          drawerPages.length,
          (index) {
            return drawerPages[index];
          },
        ),
      ),
    );
  }

  void logOut () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("email");
      Get.offAll(LoginPage(logOut: true));
  }
}
