import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:afad_app/screens/start_page.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:afad_application/help_form.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}



