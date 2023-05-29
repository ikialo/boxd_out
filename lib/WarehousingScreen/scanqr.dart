import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Utils/service_storage.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({super.key});

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String _scanBarcode = "";
  late List<String> split = [];

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    // Platform messages may fail, so we use a try/catch PlatformException.

    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#42f5ef", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    split = _scanBarcode.split(',');
    print(split);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: split.isEmpty
              ? Center(child: Text('Open Scanner and Scan Code'))
              : FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(split[0])
                      .collection('Product')
                      .doc(split[1])
                      .get(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      final weightCOnroller = TextEditingController();
                      final quantityController = TextEditingController();
                      final priceController = TextEditingController();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/bg/box1.png'),
                                  fit: BoxFit.fill),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Product Name: " +
                                        data['product_name']),
                                    Text("Description: " + data['description']),
                                    Text("Category: " + data['category']),
                                    Text("Height: " + data['height']),
                                    Text("Length: " + data['length']),
                                    Text("Width: " + data['width']),
                                  ]),
                            ),
                          ),
                          FutureBuilder(
                              future: _getImage(context, data['imagePath']),
                              builder: (ctx, snapshot) {
                                print(snapshot);
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2),
                                        borderRadius: BorderRadius.circular(
                                            20), //<-- SEE HERE
                                      ),
                                      child: snapshot.data,
                                    ),
                                  ),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: weightCOnroller,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Box Weight',
                                hintText: 'Weight',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: quantityController,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'QUantity',
                                hintText: 'Weight',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: priceController,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                border: OutlineInputBorder(),
                                labelText: 'Price',
                                hintText: 'Weight',
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(data);

                                final prod_det = <String, dynamic>{
                                  "product_name": data['product_name'],
                                  "description": data['description'],
                                  "length": data['length'],
                                  "width": data['width'],
                                  "height": data['height'],
                                  "category": data['category'],
                                  "imagePath": data['imagePath'],
                                  "weight": weightCOnroller.text,
                                  "quantity": quantityController.text,
                                  "price": priceController.text,
                                  "producer_id": split[0],
                                };

                                DocumentReference users = FirebaseFirestore
                                    .instance
                                    .collection('Product')
                                    .doc(split[1]);

                                users.set(prod_det).then((value) {
                                  print("User Added");
                                  setState(() {
                                    split.clear();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Product Added to Main DB'),
                                    ),
                                  );
                                  // Navigator.of(context).pop();
                                }).catchError((error) =>
                                    print("Failed to add user: $error"));
                              },
                              child: Text("Submit"))
                        ],
                      );
                    }

                    return Text("loading");
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcodeNormal,
        tooltip: 'Increment',
        child: Icon(Icons.camera_enhance),
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        height: 200,
        width: 300,
      );
    });
    return image;
  }
}
