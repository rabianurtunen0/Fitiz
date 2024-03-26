import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';

class FourthFrame extends StatefulWidget {
  final Function(int) moveToPage;

  const FourthFrame({Key? key, required this.moveToPage}) : super(key: key);

  @override
  _FourthFrameState createState() => _FourthFrameState();
}

class _FourthFrameState extends State<FourthFrame> {
  final _getStorage = GetStorage();
  late final TextEditingController _controller = TextEditingController();
  
  @override
void initState() {
  super.initState();
  final currentWeight = _getStorage.read('currentWeight');
  if (currentWeight != null) {
    _controller.text = currentWeight.toString();
  }
}
  
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
              'Şu andaki kilonuz ne?',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  width: MediaQuery.of(context).size.width * 0.24,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Theme.of(context).primaryColor, 
                        width: 1.5)
                      ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      cursorColor: const Color(0XFF1F1E1C),
                      style: TextStyle(
                        color: const Color(0XFF1F1E1C),
                        fontSize: ScreenUtil().setSp(12.5),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(
                          color: const Color(0XFF1F1E1C).withOpacity(0.5),
                          fontSize: ScreenUtil().setSp(12.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _getStorage.write('currentWeight', value);
                          print('Current Weight: ' + _getStorage.read('currentWeight'));
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      'kg',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(12.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          
          Container(
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.width * 0.14,
            child: MaterialButton(
              onPressed: () {
                if (_controller != null && _controller.text.isNotEmpty) {
                  widget.moveToPage(4);
                }
              },
              color: Theme.of(context).disabledColor.withOpacity(0.4),
              shape: const CircleBorder(),
              elevation: 0.0,
              highlightElevation: 0.0,
              highlightColor: Theme.of(context).disabledColor.withOpacity(0.5),
              splashColor: Theme.of(context).disabledColor.withOpacity(0.5),
              child: Icon(
                BootstrapIcons.arrow_right,
                color: Colors.white,
                size: ScreenUtil().setSp(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
