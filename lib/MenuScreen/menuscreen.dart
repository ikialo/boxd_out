import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taka_box/MainScreen/mainscreen.dart';
import 'package:taka_box/WarehousingScreen/mainwarehousescreen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  bool warehouser = false;

  @override
  void initState() {
    // TODO: implement initState

    waitForCustomClaims().then((value) {
      print(warehouser);

      setState(() {
        warehouser = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text("BOX'r")),
            warehouser
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => MainWareScreen()),
                      );
                    },
                    child: const Text('Warehouser'))
                : Container()
          ],
        ),
      ),
    );
  }

  Future<bool> waitForCustomClaims() async {
    User? curerntUser = FirebaseAuth.instance.currentUser;
    // DocumentReference userDocRef =
    //     FirebaseFirestore.instance.collection('users').doc(curerntUser!.uid);
    // Stream<DocumentSnapshot> docs =
    //     userDocRef.snapshots(includeMetadataChanges: false);

    // DocumentSnapshot data = await docs.firstWhere((DocumentSnapshot snapshot) =>
    //     snapshot.data != null && snapshot.data.containsKey('createdAt'));
    // print('data ${data.toString()}');

    IdTokenResult idTokenResult = await curerntUser!.getIdTokenResult();
    print('claims : ${idTokenResult.claims}');

    return idTokenResult.claims!['admin'];
  }
}
