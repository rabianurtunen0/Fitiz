import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class HistoricalWeighingPage extends StatefulWidget {
  const HistoricalWeighingPage({super.key});

  @override
  State<HistoricalWeighingPage> createState() => _HistoricalWeighingPageState();
}

class _HistoricalWeighingPageState extends State<HistoricalWeighingPage> {
  final _scrollController = ScrollController();
  final _getStorage = GetStorage();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:    Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05),
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  border: Border.all(
                    color: Color(0XFFBF0603),
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.04),
                      child: Text(
                        'Geçmiş Kilo Verileriniz',
                        style: TextStyle(
                            color: const Color(0XFF1F1E1C),
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(11)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.248,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(FirebaseAuth
                                        .instance.currentUser?.email)
                                    .collection('Weight')
                                    .orderBy('date', descending: true)
                                    .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index1) {
                                DocumentSnapshot documentData =
                                    snapshot.data!.docs[index1];
                                print(snapshot.data!.docs[index1]);
                                return Container(
                                    margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.048,
                                    decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .disabledColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                    child:  Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                                documentData["weight"],
                                                style: TextStyle(
                                                    color:
                                                        const Color(0XFF131C24),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(11)),
                                              ),
                                      
                                          
                                          Text(
                                            documentData["weight"],
                                            style: TextStyle(
                                                color: const Color(0XFF131C24),
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    ScreenUtil().setSp(11)),
                                          ),
                                        ],
                                      ),
                                  );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
         
      ),
    );
  }

}