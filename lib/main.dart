import 'package:firebase_core/firebase_core.dart';
import 'package:fitiz/firstPage.dart';
import 'package:fitiz/homePage.dart';
import 'package:fitiz/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  initializeDateFormatting('tr_TR', null).then((_) { 
    runApp(email == null ? const MyApp() : const MyApp2());
  runApp(const MyApp());
  }); 
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 640));
    return GetMaterialApp(
      title: 'Fitiz',
      debugShowCheckedModeBanner: false,
      locale: const Locale('tr', ''),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0XFFEAEAEA),
        primaryColor: const Color(0XFFB840CD),
        primaryColorDark: const Color(0XFF82318A),
        disabledColor: const Color(0XFF9F9B98),
        elevatedButtonTheme: ThemeStyles().elevatedButtonTheme,
      ),
      home: const FirstPage(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 640));
    return GetMaterialApp(
      title: 'Fitiz',
      debugShowCheckedModeBanner: false,
      locale: const Locale('tr', ''),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0XFFEAEAEA),
        primaryColor: const Color(0XFFB840CD),
        primaryColorDark: const Color(0XFF82318A),
        disabledColor: const Color(0XFF9F9B98),
        elevatedButtonTheme: ThemeStyles().elevatedButtonTheme,
      ),
      home: const HomePage(selectedIndex: 1),
    );
  }
}