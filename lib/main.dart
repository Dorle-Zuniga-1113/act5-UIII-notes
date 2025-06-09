import 'package:flutter/material.dart';
import 'package:myapp/notes.dart';
import 'package:firebase_core/firebase_core.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDBFrYTPsBeQt0yFTGCeUF7D6p0l_rO7Vg", 
      appId: "1:566310935734:android:d2124d3993ee370eda1a17", 
      messagingSenderId: "566310935734", 
      projectId: "notes-login-c4020")
   );
  
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Notes());
  }
}
