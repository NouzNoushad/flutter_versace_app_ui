import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

// we need apikey and projectId, lets go and get it from firebase

const apiKey = "AIzaSyC1bn28TBvZZ3lVgGusWwcHOw_NBrvWnsU";
const projectId = "men-collections-e925f";

void main() {
  Firestore.initialize(projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
