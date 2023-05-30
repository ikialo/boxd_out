import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taka_box/MainScreen/addproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taka_box/MainScreen/qrimage.dart';
import 'package:taka_box/UI/Color_template.dart';

import '../Utils/service_storage.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  final ref = FirebaseStorage.instance.ref();

  Future<String> getUrl(ref1, element) async {
    var url = await ref1.child(element["imagePath"]).getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Product')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                  child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 16 / 7,
                              crossAxisCount: 1,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        DocumentSnapshot element = snapshot.data!.docs[index];

                        return InkWell(
                          onTap: () {
                            print(element.id);
                            QRDialog(
                                context,
                                FirebaseAuth.instance.currentUser!.uid,
                                element.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/bg/box1.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        element['product_name'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        element['description'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(
                                        element['category'],
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      // CircularPercentIndicator(
                                      //   radius: 30,
                                      //   lineWidth: 8,
                                      //   animation: true,
                                      //   animationDuration: 1500,
                                      //   circularStrokeCap: CircularStrokeCap.round,
                                      //   percent: course[index].percent / 100,
                                      //   progressColor: Colors.white,
                                      //   center: Text(
                                      //     "${course[index].percent}%",
                                      //     style: const TextStyle(color: Colors.white),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FutureBuilder(
                                          future: _getImage(
                                              context, element['imagePath']),
                                          builder: (ctx, snapshot) {
                                            print(snapshot);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  child: snapshot.data,
                                                ),
                                              ),
                                            );
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })

                  //   ListView.builder(
                  //       itemCount: snapshot.data!.docs.length,
                  //       itemBuilder: (context, index) {
                  //         DocumentSnapshot element = snapshot.data!.docs[index];

                  //         return Padding(
                  //           padding: const EdgeInsets.only(left: 12, right: 12),
                  //           child: InkWell(
                  //             onTap: () {
                  //               print(element.id);
                  //               QRDialog(context,
                  //                   FirebaseAuth.instance.currentUser!.uid, element.id);
                  //             },
                  //             child: Card(
                  //               elevation: 10,
                  //               child: Column(children: [
                  //                 ListTile(
                  //                   leading: Icon(Icons.production_quantity_limits),
                  //                   title: Text(element['product_name']),
                  //                   subtitle: Text(element['description']),
                  //                   trailing: Text(element['category']),
                  //                 ),
                  //                 FutureBuilder(
                  //                     future: _getImage(context, element['imagePath']),
                  //                     builder: (ctx, snapshot) {
                  //                       print(snapshot);
                  //                       return Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Align(
                  //                           alignment: Alignment.topCenter,
                  //                           child: Container(
                  //                             child: snapshot.data,
                  //                           ),
                  //                         ),
                  //                       );
                  //                     })
                  //               ]),
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  ),
            );
          },
        ),
      ),
      floatingActionButton: AddProduct(),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        height: 100,
        width: 100,
      );
    });
    return image;
  }

  QRDialog(BuildContext context, String user_id, String product_id) {
    double width = MediaQuery.of(context).size.width;
    // final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 10.0,
          child: Expanded(
            child: Container(
              width: width > 650 ? width / 2 : width,
              height: MediaQuery.of(context).size.height / 2,
              // height: 23.5.h,
              // height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kTertiaryColor4,
                            kTertiaryColor3,
                            kTertiaryColor2,
                            kTertiaryColor,
                          ],
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          //-------------------------------------- Pack Title
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Scan QR Code',
                              style: TextStyle(
                                fontSize: 17,
                                color: kTertiaryColor5,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NewYork',
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          Divider(color: kTertiaryColor5),
                          //----------------------------------------------- Features
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 1),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Text(
                                'Scan QR Code to Get Product Detail',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'NewYork',
                                  color: kTertiaryColor5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: QRImage(user_id + ',' + product_id))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
