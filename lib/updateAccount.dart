import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

class UpdateAccount extends StatefulWidget {
  final activityIndex;
  final age;
  final birthDate;
  final email;
  final gender;
  final genderIndex;
  final height;
  final nameAndSurname;
  final targetIndex;
  final weight;
  final weightToLose;
  final calorie;
  const UpdateAccount(
      {Key? key,
      required this.activityIndex,
      required this.age,
      required this.birthDate,
      required this.email,
      required this.gender,
      required this.genderIndex,
      required this.height,
      required this.nameAndSurname,
      required this.targetIndex,
      required this.weight,
      required this.weightToLose,
      required this.calorie})
      : super(key: key);

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _controller = ScrollController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordAgainController = TextEditingController();

  int activityIndex = 0;
  bool changePassword = false;
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool newPasswordAgainVisible = true;
  bool update = false;
  

  double calorie = 0;

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
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.weight);
    heightController = TextEditingController(text: widget.height);
    activityIndex = widget.activityIndex;
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  MediaQuery.of(context).size.height * 0.05,
                  MediaQuery.of(context).size.width * 0.02,
                  MediaQuery.of(context).size.height * 0.01,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.036),
                width: MediaQuery.of(context).size.width * 0.24,
                height: MediaQuery.of(context).size.width * 0.24,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: widget.gender == 'female'
                            ? const Color(0XFFEE0475)
                            : const Color(0XFF08C5FF),
                        width: 1.5)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: widget.gender == 'female'
                        ? SvgPicture.asset('assets/images/woman.svg',
                            color: const Color(0XFFEE0475))
                        : SvgPicture.asset('assets/images/man.svg',
                            color: const Color(0XFF08C5FF))),
              ),
              Text(
                widget.nameAndSurname,
                style: TextStyle(
                  color: const Color(0XFF1F1E1C),
                  fontSize: ScreenUtil().setSp(11.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.004,
                  ),
                  child: Text(
                    widget.email,
                    style: TextStyle(
                      color: const Color(0XFF1F1E1C).withOpacity(0.6),
                      fontSize: ScreenUtil().setSp(9.5),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.height * 0.003),
                          child: Text(
                            'Yaş',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.048,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).disabledColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.age.toString(),
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.068,
                              0.0,
                              MediaQuery.of(context).size.width * 0.05,
                              MediaQuery.of(context).size.height * 0.003),
                          child: Text(
                            'Kilo (kg)',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              0.0,
                              MediaQuery.of(context).size.width * 0.05,
                              0.0),
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.048,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).disabledColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              cursorColor: const Color(0XFFB840CD),
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(10.5),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.height * 0.003),
                          child: Text(
                            'Boy (cm)',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.048,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).disabledColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              cursorColor: const Color(0XFFB840CD),
                              maxLines: null,
                              expands: true,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(10.5),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.018,
                        0.0,
                        0.0,
                        MediaQuery.of(context).size.height * 0.003),
                    child: Text(
                      'Hareket Düzeyi',
                      style: TextStyle(
                        color: const Color(0XFF1F1E1C),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(10.5),
                      ),
                    ),
                  ), 
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.048,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<int>(
                        value: activityIndex,
                        onChanged: (int? newIndex) {
                          setState(() {
                            activityIndex = newIndex!;
                          });
                        },
                        items: activityLevel
                            .asMap()
                            .entries
                            .map<DropdownMenuItem<int>>((entry) {
                          int idx = entry.key;
                          String level = entry.value;
                          return DropdownMenuItem<int>(
                            value: idx,
                            child: Text(
                              level,
                              style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        underline: SizedBox(),
                        icon: Container(
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                          child: Icon(
                            BootstrapIcons.chevron_down,
                            color: const Color(0XFF1F1E1C),
                            size: ScreenUtil().setSp(14),
                          ),
                        ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ],
              ),       
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.045),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      BootstrapIcons.fire,
                      color: const Color(0XFF5E5F54).withOpacity(0.4),
                      size: ScreenUtil().setSp(52.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.068,
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.height * 0.003),
                          child: Text(
                            'Günlük Kalori Miktarı',
                            style: TextStyle(
                              color: const Color(0XFF1F1E1C),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(10.5),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.05,
                              0.0,
                              0.0,
                              MediaQuery.of(context).size.height * 0.003),
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.048,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).disabledColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$calorie kcal',
                              style: TextStyle(
                                color: const Color(0XFFBF0603),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.012,
                    MediaQuery.of(context).size.height * 0.048,
                    MediaQuery.of(context).size.width * 0.012,
                    0.0),
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.52,
                          height: MediaQuery.of(context).size.height * 0.042,
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.018,
                              MediaQuery.of(context).size.height * 0.006,
                              MediaQuery.of(context).size.width * 0.036,
                              MediaQuery.of(context).size.height * 0.006),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                changePassword = !changePassword;
                                update = true;
                              });
                            },
                            style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Şifre Güncelleme',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                color: const Color(0XFF1F1E1C),
                                fontSize: ScreenUtil().setSp(11.5),
                                fontWeight: FontWeight.w500,
                              ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                changePassword = !changePassword;
                                update = true;
                              });
                            },
                            splashRadius: 1.0,
                            icon: Icon(
                              BootstrapIcons.chevron_down,
                              color: const Color(0XFF1F1E1C),
                              size: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    changePassword
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.048,
                                    MediaQuery.of(context).size.height * 0.003,
                                    MediaQuery.of(context).size.width * 0.012,
                                    0.0),
                                alignment: Alignment.center,
                                child: Icon(
                                  BootstrapIcons.lock,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(14),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.52,
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.018,
                                    MediaQuery.of(context).size.height * 0.015,
                                    MediaQuery.of(context).size.width * 0.036,
                                    MediaQuery.of(context).size.height * 0.006),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: oldPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: oldPasswordVisible,
                                  obscuringCharacter: '•',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "⛔ This field is required";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    oldPasswordController.text = newValue!;
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  textInputAction: TextInputAction.next,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: const Color(0XFF131C24),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'Old Password',
                                    labelStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: '••••••••',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).disabledColor),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          oldPasswordVisible =
                                              !oldPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        oldPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: const Color(0XFF131C24)
                                            .withOpacity(0.6),
                                        size: ScreenUtil().setSp(15),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0,
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    changePassword
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.048,
                                    MediaQuery.of(context).size.height * 0.003,
                                    MediaQuery.of(context).size.width * 0.012,
                                    0.0),
                                alignment: Alignment.center,
                                child: Icon(
                                  BootstrapIcons.lock,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(14),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.52,
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.018,
                                    MediaQuery.of(context).size.height * 0.015,
                                    MediaQuery.of(context).size.width * 0.036,
                                    MediaQuery.of(context).size.height * 0.006),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: newPasswordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: newPasswordVisible,
                                  obscuringCharacter: '•',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "⛔ This field is required";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    newPasswordController.text = newValue!;
                                  },
                                  cursorColor: Theme.of(context).highlightColor,
                                  textInputAction: TextInputAction.next,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: const Color(0XFF131C24),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'New Password',
                                    labelStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: '••••••••',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).disabledColor),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          newPasswordVisible =
                                              !newPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        newPasswordVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: const Color(0XFF131C24)
                                            .withOpacity(0.6),
                                        size: ScreenUtil().setSp(15),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0,
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    changePassword
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.048,
                                    MediaQuery.of(context).size.height * 0.003,
                                    MediaQuery.of(context).size.width * 0.012,
                                    0.0),
                                alignment: Alignment.center,
                                child: Icon(
                                  BootstrapIcons.lock,
                                  color: Theme.of(context).primaryColor,
                                  size: ScreenUtil().setSp(14),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.52,
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.018,
                                    MediaQuery.of(context).size.height * 0.015,
                                    MediaQuery.of(context).size.width * 0.036,
                                    MediaQuery.of(context).size.height * 0.006),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: newPasswordAgainController,
                                  keyboardType: TextInputType.text,
                                  obscureText: newPasswordAgainVisible,
                                  obscuringCharacter: '•',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "⛔ This field is required";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    newPasswordAgainController.text = newValue!;
                                  },
                                  cursorColor: Theme.of(context).highlightColor,
                                  textInputAction: TextInputAction.next,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(12),
                                    color: const Color(0XFF131C24),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    labelText: 'New Password',
                                    labelStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).primaryColor),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintText: '••••••••',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: Theme.of(context).disabledColor),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          newPasswordAgainVisible =
                                              !newPasswordAgainVisible;
                                        });
                                      },
                                      icon: Icon(
                                        newPasswordAgainVisible
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: const Color(0XFF131C24)
                                            .withOpacity(0.6),
                                        size: ScreenUtil().setSp(15),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0,
                                        MediaQuery.of(context).size.width * 0.03,
                                        0.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).disabledColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.0, MediaQuery.of(context).size.height * 0.022, 0.0, 0.0),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.048,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fetchUpdateData();
                    });
                    Get.back();
                  },
                  child: const Text('Güncelle'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchUpdateData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      DocumentReference doc =
          FirebaseFirestore.instance.collection('Users').doc(email);

      await doc.update({'weight': weightController.text.toString()});
      await doc.update({'height': heightController.text.toString()});
      await doc.update({'activityIndex': activityIndex});

      calculateCalorie();
      await doc.update({'calorie': calorie});

      
    }
  }

  void calculateCalorie() async {
    double activityLevelValue = 0.0;
    if (activityIndex == 0) {
      activityLevelValue = 1.2;
    } else if (activityIndex == 1) {
      activityLevelValue = 1.375;
    } else if (activityIndex == 2) {
      activityLevelValue = 1.55;
    } else if (activityIndex == 3) {
      activityLevelValue = 1.725;
    } else if (activityIndex == 4) {
      activityLevelValue = 1.9;
    }

    if (widget.gender == 'female') {
      double bmr = 66.5 +
          (13.75 * int.parse(weightController.text)) +
          (5 * int.parse(heightController.text)) -
          (6.77 * widget.age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');
    } else if (widget.gender == 'male') {
      double bmr = 655.1 +
          (9.56 * int.parse(weightController.text)) +
          (1.85 * int.parse(heightController.text)) -
          (4.67 * widget.age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');
    } else {
      double bmr = 66.5 +
          (13.75 * int.parse(weightController.text)) +
          (5 * int.parse(heightController.text)) -
          (6.77 * widget.age);
      calorie = bmr * activityLevelValue;
      print('Kalori değeri $calorie');
    }
  }

  void updateData() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email.toString(),
          password: oldPasswordController.text);

      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPasswordController.text).then((_) {
          Fluttertoast.showToast(
            msg: "Your information has been successfully changed",
            backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
          );
        }).catchError((error) {
          print("Error " + error.toString());
        });
      }).catchError((e) {
        Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.4),
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(12),
        );
      });

    }
  }

}
