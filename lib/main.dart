import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newstudent/db/model/studentmodel.dart';
import 'package:newstudent/screen_home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
  };
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    home: ScreenHome(),
  ));
}