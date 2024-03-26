import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/account/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final emailEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fromKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isEmailInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        leading: Container(
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
          child: Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.09,
                0.0, MediaQuery.of(context).size.width * 0.09, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.014,
                          0.0,
                          0.0,
                          MediaQuery.of(context).size.height * 0.006),
                      child: SvgPicture.asset(
                        'assets/images/fitiz_logo.svg',
                        height: MediaQuery.of(context).size.height * 0.068,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.02,
                          MediaQuery.of(context).size.height * 0.0024,
                          0.0,
                          MediaQuery.of(context).size.height * 0.004),
                      child: Text(
                        'Şifrenizi unuttuysanız, şifre sıfırlama bağlantısı gönderebilirsiniz.',
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
                  margin: EdgeInsets.fromLTRB(
                      0.0, 0.0, 0.0, MediaQuery.of(context).size.height * 0.03),
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
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.052,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        resetPassword();
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
                            height: MediaQuery.of(context).size.height * 0.032,
                            width: MediaQuery.of(context).size.height * 0.032,
                            child: const CircularProgressIndicator(
                              color: Color(0XFFFFFDFA),
                              strokeWidth: 2.0,
                            ),
                          )
                        : const Text('Gönder'),
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
                        "Şifrenizi hatırladınız mı?",
                        style: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(10.5),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginPage(
                            logOut: false,
                          ));
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        child: Text(
                          'Giriş Yap',
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
    );
  }


  void resetPassword() async {
    if (_fromKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(
            email: emailEditingController.text.trim());
        Fluttertoast.showToast(
          msg: "Şifre sıfırlama bağlantısı gönderildi",
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12),
        );
        Get.back();
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12),
        );
      }
    }
  }


}
