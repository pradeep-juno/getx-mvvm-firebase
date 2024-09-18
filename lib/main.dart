import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_mvvm_firebase/views/customer_views.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for both Web and Mobile platforms
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC0tHRri1mrKyuJI3ZfQgmQC9g1_IAKWMQ",
          authDomain: "getx-mvvm-firebase-74f8d.firebaseapp.com",
          projectId: "getx-mvvm-firebase-74f8d",
          storageBucket: "getx-mvvm-firebase-74f8d.appspot.com",
          messagingSenderId: "221443903147",
          appId: "1:221443903147:web:f5572a7212414e4a35b1ee",
          measurementId: "G-QKTQBJ3W7B"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mansion Hotel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerView(),
    );
  }
}
