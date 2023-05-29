import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../UI/Color_template.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref().child("images");

  User? user = FirebaseAuth.instance.currentUser;

  // final user = <String, dynamic>{
  //   "first": "Ada",
  //   "last": "Lovelace",
  //   "born": 1815
  // };

  @override
  void initState() {
    // TODO: implement initState
    print(user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.amberAccent,
        color: Colors.amber,
        onPressed: () {
          buyDialog(context, "test", 12);
          // db.collection("users").add(user).then((DocumentReference doc) =>
          //     print('DocumentSnapshot added with ID: ${doc.id}'));
        },
        icon: Icon(
          Icons.add_rounded,
          color: Colors.amber,
        ));
  }

  buyDialog(BuildContext context, String service, int amount) {
    double width = MediaQuery.of(context).size.width;
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final productCOnroller = TextEditingController();
    final descriptionController = TextEditingController();
    final lengthController = TextEditingController();
    final widthCOnroller = TextEditingController();
    final heightController = TextEditingController();
    final caegoryController = TextEditingController();
    String filepath = 'No File Chosen';

    late File filepath_;

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
              height: MediaQuery.of(context).size.height - 100,
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
                              'Add Item',
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
                                'Add an item to your product list',
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
                    //------------------------------------    Buy Now

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: productCOnroller,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Product Name',
                          hintText: 'hint',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Product Description',
                          hintText: 'hint',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: lengthController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Box Length',
                          hintText: 'hint',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: widthCOnroller,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Box Width',
                          hintText: 'hint',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: heightController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Box Height',
                          hintText: 'hint',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: caegoryController,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(),
                          labelText: 'Category',
                          hintText: 'hint',
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        IconButton(
                          style: style,
                          onPressed: () async {
                            FilePickerResult? picked =
                                await FilePicker.platform.pickFiles();

                            if (picked != null) {
                              print(picked.files.single.path);
                              filepath_ =
                                  File(picked.files.single.path.toString());

                              setState(() {
                                filepath = picked.files.single.name;
                              });
                            }
                          },
                          icon: Icon(Icons.image),
                        ),
                        Text(filepath)
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () async {
                              uploadFile(filepath_, filepath).then((value) {
                                print(value!.snapshot.ref.fullPath);

                                final prod_det = <String, dynamic>{
                                  "product_name": productCOnroller.text,
                                  "description": descriptionController.text,
                                  "length": lengthController.text,
                                  "width": widthCOnroller.text,
                                  "height": heightController.text,
                                  "category": caegoryController.text,
                                  "imagePath": value.snapshot.ref.fullPath
                                };

                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .collection('Product');
                                users.add(prod_det).then((value) {
                                  print("User Added");
                                  Navigator.of(context).pop();
                                }).catchError((error) =>
                                    print("Failed to add user: $error"));
                              });
                            },
                            child: Text('Upload')))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<UploadTask?> uploadFile(File? file, String fileName) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref =
        FirebaseStorage.instance.ref().child("boxedOut").child(fileName);

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    uploadTask = ref.putFile(File(file.path), metadata);

    return Future.value(uploadTask);
  }
}
