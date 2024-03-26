import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/account/passwordResetPage.dart';
import 'package:fitiz/account/profileSettingPage.dart';
import 'package:fitiz/account/signUpPage.dart';
import 'package:fitiz/firstPage.dart';
import 'package:fitiz/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  bool logOut;
  LoginPage({Key? key, required this.logOut}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scrollController = ScrollController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _getStorage = GetStorage();
  final _fromKey = GlobalKey<FormState>();
  bool _isVisible = true;
  bool _isChecked = false;
  bool _isLoading = false;
  bool _isEmailInvalid = false;
  bool _isPasswordInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0, 
        leading: widget.logOut == true 
          ? Container()
          : Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Get.back();
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
      body: SafeArea(
        child: Form(
          key: _fromKey,
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.09,
                    0.0,
                    MediaQuery.of(context).size.width * 0.08,
                    0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.014,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.007),
                      child: SvgPicture.asset(
                        'assets/images/fitiz_logo.svg',
                        height: MediaQuery.of(context).size.height * 0.068,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          MediaQuery.of(context).size.height * 0.0025,
                          0.0,
                          MediaQuery.of(context).size.height * 0.004),
                      child: Text(
                        'Hoş geldiniz, lütfen hesabınıza giriş yapın.',
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(12.5),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.028,
                          MediaQuery.of(context).size.height * 0.036,
                          0.0,
                          MediaQuery.of(context).size.height * 0.006),
                      child: Text(
                        'E-posta Adresi',
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0,
                            MediaQuery.of(context).size.height * 0.03),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: _isEmailInvalid ? MediaQuery.of(context).size.height * 0.089 : MediaQuery.of(context).size.height * 0.052,
                        child: TextFormField(
                          enableInteractiveSelection: true,
                          autofocus: false,
                          controller: emailEditingController,
                          keyboardType: TextInputType.text,
                          toolbarOptions: const ToolbarOptions(
                              paste: true, cut: true, selectAll: true, copy: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              _isEmailInvalid = true;
                              return "⛔ Bu alan gereklidir";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              _isEmailInvalid = true;
                              return "⛔ Lütfen geçerli bir e-posta adresi giriniz";
                            }
                            _isEmailInvalid = false;
                            return null;
                          },
                          onSaved: (newValue) {
                            emailEditingController.text = newValue!;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(11.5),
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.028,
                                0.0,
                                MediaQuery.of(context).size.width * 0.028,
                                0.0),
                            hintText: 'adınız@örnek.com',
                            hintStyle: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(11.5),
                          ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).disabledColor),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).disabledColor),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).disabledColor),
                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.028),
                          child: Text(
                            'Şifre',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.028,
                            child: MaterialButton(
                              onPressed: () {
                                Get.to(const PasswordResetPage());
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                'Şifrenizi mi unuttunuz?',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: ScreenUtil().setSp(10.5),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0,
                          MediaQuery.of(context).size.height * 0.03),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: _isPasswordInvalid ? MediaQuery.of(context).size.height * 0.089 : MediaQuery.of(context).size.height * 0.052,
                      child: TextFormField(
                        enableInteractiveSelection: true,
                        autofocus: false,
                        controller: passwordEditingController,
                        keyboardType: TextInputType.text,
                        toolbarOptions: const ToolbarOptions(
                            paste: true, cut: true, selectAll: true, copy: true),
                        obscureText: _isVisible,
                        obscuringCharacter: '•',
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{8,}$');
                          if (value!.isEmpty) {
                            _isPasswordInvalid = true;
                            return "⛔ Bu alan gereklidir";
                          }
                          if (!regex.hasMatch(value)) {
                            _isPasswordInvalid = true;
                            return "⛔ Minimum 8 karakterli bir şifre giriniz";
                          }
                          _isPasswordInvalid = false;
                          return null;
                        },
                        onSaved: (newValue) {
                          passwordEditingController.text = newValue!;
                        },
                        cursorColor: Theme.of(context).primaryColor,
                        textInputAction: TextInputAction.next,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          color: const Color(0XFF1F1E1C),
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(11.5),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.028,
                              0.0,
                              MediaQuery.of(context).size.width * 0.028,
                              0.0),
                          hintText: '••••••••',
                          hintStyle: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(11.5),
                        ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0XFF1F1E1C),
                              size: 18.0,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).disabledColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).disabledColor),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).disabledColor),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0,
                          MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.052,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            login(emailEditingController.text,
                              passwordEditingController.text);
                            _isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              _isLoading = false;
                            });
                          });
                        },
                        child: _isLoading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.032,
                                width: MediaQuery.of(context).size.height * 0.032,
                                child: const CircularProgressIndicator(
                                  color: Color(0XFFFFFDFA),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Text('Giriş Yap'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabınız yok mu?",
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(const ProfileSettingPage());
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                            child: Text('Üye Ol',
                                style: TextStyle(
                                    color: const Color(0XFF5E5F54),
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(10.5),
                                    decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  
  void login(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _isLoading = true;
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((email) async => {
                Fluttertoast.showToast(
                  msg: "Başarıyla giriş yapıldı :)",
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
                  textColor: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                ),
                Get.to(const HomePage(selectedIndex: 1)),
                prefs.remove("email"),
                prefs.setString("email", email.toString()),
              })
          .catchError((e) {
        Fluttertoast.showToast(
          msg: "Üzgünüz giriş yapamadınız. Lütfen bilgilerinizi kontrol ediniz.",
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12),
        );
      });
    }
  }
  


}
