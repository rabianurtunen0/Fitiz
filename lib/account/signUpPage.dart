import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitiz/account/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _scrollController = ScrollController();
  final nameAndSurnameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final againPasswordEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _getStorage = GetStorage();
  final _fromKey = GlobalKey<FormState>();
  bool _isVisible = true;
  bool _isLoading = false;
  bool _isNameAndSurnameInvalid = false;
  bool _isEmailInvalid = false;
  bool _isPasswordInvalid = false;

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
            child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.09,
                  0.0,
                  MediaQuery.of(context).size.width * 0.09,
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
                      'Lütfen, bilgilerinizi doldurun ve üyeliğinizi tamamlayın.',
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
                      'İsim - Soyisim',
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
                    height: _isNameAndSurnameInvalid ? MediaQuery.of(context).size.height * 0.089 : MediaQuery.of(context).size.height * 0.052,
                    child: TextFormField(
                      enableInteractiveSelection: true,
                      autofocus: false,
                      controller: nameAndSurnameEditingController,
                      keyboardType: TextInputType.text,
                      toolbarOptions: const ToolbarOptions(
                          paste: true, cut: true, selectAll: true, copy: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          _isNameAndSurnameInvalid = true;
                          return "⛔ Bu alan gereklidir";
                        }
                        _isNameAndSurnameInvalid = false;
                        return null;
                      },
                      onSaved: (newValue) {
                        nameAndSurnameEditingController.text = newValue!;
                      },
                      cursorColor: Theme.of(context).disabledColor,
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
                        hintText: 'İsim - Soyisim',
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
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.028,
                        0.0,
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
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.028,
                        0.0,
                        0.0,
                        MediaQuery.of(context).size.height * 0.006),
                    child: Text(
                      'Şifre',
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
                          createAccount(emailEditingController.text,
                              passwordEditingController.text);
                          _isLoading = true;
                          _getStorage.write('nameAndSurname', nameAndSurnameEditingController.text);

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
                          : const Text('Üye Ol'),
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
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }


  void createAccount(String email, String password) async {
    if (_fromKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async => {
                await _firestore.collection('Users').doc(email).set({
                  'nameAndSurname': nameAndSurnameEditingController.text,
                  'email': email,
                  'targetIndex': _getStorage.read('targetIndex'),
                  'weightToLose': _getStorage.read('weightToLose'),
                  'weight': _getStorage.read('currentWeight'),
                  'height': _getStorage.read('height'),
                  'activityIndex': _getStorage.read('activityIndex'),
                  'gender': _getStorage.read('gender'),
                  'genderIndex': _getStorage.read('genderIndex'),
                  'birthDate': _getStorage.read('birthDate'),
                  'age': _getStorage.read('age'),
                  'calorie': _getStorage.read('calorie')
                }),
                Fluttertoast.showToast(
                  msg: "Hesap başarıyla oluşturuldu :) ",
                  backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
                  textColor: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                ),
                Get.to(LoginPage(logOut: false)),
              })
          .catchError((e) {
        Fluttertoast.showToast(
          msg: e!.message,
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
          textColor: Colors.white,
          fontSize: ScreenUtil().setSp(12),
        );
      });
    }
  }
  
}
